//
//  CTSettingsController.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/7.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTSettingsController.h"
#import "CTWebController.h"

@interface CTSettingsController ()

@property (nonatomic, strong) UIButton *baiduBtn;
@property (nonatomic, strong) UIButton *baiduPresentBtn;

@end

@implementation CTSettingsController

#pragma mark -lazy load
- (UIButton *)baiduBtn {
    if (!_baiduBtn) {
        _baiduBtn = [UIButton randomBtn];
        [_baiduBtn setTitle:@"百度一下" forState:UIControlStateNormal];
        _baiduBtn.tag = 0;
        [_baiduBtn addTarget:self action:@selector(baiduBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _baiduBtn;
}

- (UIButton *)baiduPresentBtn {
    if (!_baiduPresentBtn) {
        _baiduPresentBtn = [UIButton randomBtn];
        [_baiduPresentBtn setTitle:@"百度一下" forState:UIControlStateNormal];
        _baiduPresentBtn.tag = 1;
        [_baiduPresentBtn addTarget:self action:@selector(baiduBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _baiduPresentBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    [self setupUI];
}

- (void)setupUI {
    [super setupUI];
    
    self.baiduBtn.frame = CGRectMake((SCREEN_Width - 100)/2.0, 100, 100, 40);
    [self.view addSubview:self.baiduBtn];
    
    [self.view addSubview:self.baiduPresentBtn];
    [self.baiduPresentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
}

// 重置导航栏返回按钮
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 44);
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setImage:[UIImage imageNamed:@"back_arrow_white"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)baiduBtnClick:(UIButton *)btn {
    CTWebController *web = [[CTWebController alloc] init];
    web.urlString = @"https://www.baidu.com";
    if (btn.tag == 0) {
        web.displayType = CTWebDisplayTypePush;
        [self.navigationController pushViewController:web animated:YES];
    } else {
        web.displayType = CTWebDisplayTypePresent;
        CTNavigationController *nav = [[CTNavigationController alloc] initWithRootViewController:web];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

@end
