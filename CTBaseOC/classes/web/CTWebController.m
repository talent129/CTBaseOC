//
//  CTWebController.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/7.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTWebController.h"
#import <WebKit/WebKit.h>

@interface CTWebController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation CTWebController

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.backgroundColor = [UIColor appColorWhite];
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES; //允许右滑返回上一页(web页面)
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.backgroundColor = [UIColor clearColor];//背景色-若trackTintColor为clearColor,则显示背景颜色
        _progressView.progressTintColor = [UIColor progressColor];//进度条颜色
        _progressView.trackTintColor = [UIColor clearColor];//进度条还未到达的线条颜色
        _progressView.progress = 0.3;
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.navigationTitle;
    [self setupUI];
    [self addObserver];
    
    NSURL *url;
    if (!StrEmpty(self.urlString)) {
        url = [NSURL URLWithString:self.urlString];
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)addObserver {
    [self.webView addObserver:self forKeyPath:NSStringFromSelector(@selector(title)) options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setupUI {
    [super setupUI];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@2);
    }];
    
    if (self.displayType == CTWebDisplayTypePresent) {
        [self addNavigationImageItem:[UIImage imageNamed:@"dismiss"] withLeft:YES withTarget:self withAction:@selector(backBtnClick)];
    }
}

/// KVO获取网页title、progress
/// - Parameters:
///   - keyPath: 路径
///   - object: 对象
///   - change: 改变
///   - context: 上下文
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(title))]) {
        if ([object isEqual:self.webView]) {
            NSLog(@"-title:%@", self.webView.title);
            if (StrEmpty(self.navigationTitle)) {
                self.title = self.webView.title;
            }
        }
    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]) {
        if ([object isEqual:self.webView]) {
            NSLog(@"-change: %@ ---estimatedProgress: %f", change, self.webView.estimatedProgress);
            if ([change[@"new"] floatValue] > self.progressView.progress) {
                [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark -WKNavigationDelegate
///发送请求之前 决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"--发送请求之前 决定是否跳转-decidePolicyForNavigationAction");
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

///页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"--页面开始加载调用-didStartProvisionalNavigation");
    self.progressView.hidden = NO;
    [self.view bringSubviewToFront:self.progressView];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"--接收到响应后，决定是否跳转--decidePolicyForNavigationResponse");
    
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"--当内容开始返回时调用-didCommitNavigation");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"--页面加载完成之后调用-didFinishNavigation");
    self.progressView.hidden = YES;
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"--接收到服务器跳转请求之后-didReceiveServerRedirectForProvisionalNavigation");
}

#if DEBUG
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, card);
    }
}
#endif

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"--页面加载失败调用-didFailProvisionalNavigation");
    self.progressView.hidden = YES;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(title))];
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

- (void)backBtnClick {
    if (self.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
