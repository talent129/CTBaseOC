//
//  CTBaseController.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTBaseController.h"

@interface CTBaseController ()

@property (nonatomic, assign) BOOL refreshing;

@end

@implementation CTBaseController

#pragma mark -
- (MJRefreshNormalHeader *)ct_header {
    if (!_ct_header) {
        _ct_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onRefresh)];
    }
    return _ct_header;
}

- (MJRefreshBackNormalFooter *)ct_footer {
    if (!_ct_footer) {
        _ct_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onLoadMore)];
    }
    return _ct_footer;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

// 状态栏默认黑色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;//不延伸
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.view.backgroundColor = [UIColor backgroundColor];
    [self configData];
}

- (void)configData {
    self.pageNum = 1;
}

- (void)configTranslucentNavbar {
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
        barApp.backgroundColor = [UIColor clearColor];
        barApp.backgroundEffect = nil;
        barApp.shadowColor = nil;
        self.navigationController.navigationBar.scrollEdgeAppearance = nil;
        self.navigationController.navigationBar.standardAppearance = barApp;
    } else {
        //背景色
        self.navigationController.navigationBar.tintColor = [UIColor clearColor];
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
}

- (void)configTranslucentNavbarWithBackgroundColor:(UIColor *)backgroundColor {
    [self configTranslucentNavbar];
    UIView *topView = [UIView new];
    topView.backgroundColor = backgroundColor;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(-kNavBarHeight);
        make.height.equalTo(@(kNavBarHeight));
    }];
}

- (void)configLightStyleNavbar {
    NSDictionary *titleAttr = @{NSFontAttributeName:[UIFont fontBold:18],
                                NSForegroundColorAttributeName:[UIColor appColorWhite]};
    if (@available(iOS 13.0, *)) {
        self.navigationController.navigationBar.standardAppearance.titleTextAttributes = titleAttr;
    } else {
        self.navigationController.navigationBar.titleTextAttributes = titleAttr;
    }
}

- (void)configDarkStyleNavbar {
    NSDictionary *titleAttr = @{NSFontAttributeName:[UIFont fontBold:18],
                                NSForegroundColorAttributeName:[UIColor textColor]};
    if (@available(iOS 13.0, *)) {
        self.navigationController.navigationBar.standardAppearance.titleTextAttributes = titleAttr;
    } else {
        self.navigationController.navigationBar.titleTextAttributes = titleAttr;
    }
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 44);
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setImage:[UIImage imageNamed:@"back_arrow_black"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

// UI
- (void)setupUI {
    
}

// 请求
- (void)request {
    
}

- (void)onRefresh {
    if (self.refreshing) {
        return;
    }
    self.pageNum = 1;
    self.refreshing = YES;
    [self request];
}

- (void)onLoadMore {
    if (self.refreshing) {
        return;
    }
    self.pageNum += 1;
    self.refreshing = YES;
    [self request];
}

- (void)endRefresh {
    [self.ct_header endRefreshing];
    [self.ct_footer endRefreshing];
    self.refreshing = NO;
}

- (void)endRefreshNoMoreData {
    [self.ct_footer endRefreshing];
    [self.ct_footer endRefreshingWithNoMoreData];
    self.refreshing = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    NSLog(@"dealloc - %@", NSStringFromClass([self class]));
}

#pragma mark -DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *imageName = @"empty";
    //判断网络状态
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status == NotReachable) {
        imageName = @"network";
    }
    return [UIImage imageNamed:imageName];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor backgroundColor];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无数据";
    //判断网络状态
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status == NotReachable) {
        text = @"暂无网络";
    }
    NSDictionary *dic = @{NSFontAttributeName: [UIFont fontMedium16], NSForegroundColorAttributeName: [UIColor secondaryColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:dic];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -kNavBarHeight/2.0;
}

#pragma mark -DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

@end
