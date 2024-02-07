//
//  CTMineController.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTMineController.h"
#import "CTLoginController.h"
#import "CTSettingsController.h"

@interface CTMineController ()

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *loginBtn1;

@end

@implementation CTMineController

// 修改本页面状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -lazy load
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton btnWithBGColor:[UIColor themeColor] tag:-1 radius:CTScale(10) title:@"去登录-push" titleColor:[UIColor appColorWhite] fontSize:16];
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)loginBtn1 {
    if (!_loginBtn1) {
        _loginBtn1 = [UIButton btnWithBGColor:[UIColor themeColor] tag:-1 radius:CTScale(10) title:@"去登录-present" titleColor:[UIColor appColorWhite] fontSize:16];
        [_loginBtn1 addTarget:self action:@selector(loginBtnClick1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的";
    self.view.backgroundColor = [UIColor randomColor];
    
    // 设置导航栏右侧按钮
    [self addNavigationTitleItem:@"设置" tintColor:[UIColor appColorWhite] withLeft:NO withTarget:self withAction:@selector(goSettings)];
    
    [self setupUI];
}

- (void)setupUI {
    [super setupUI];
    
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.loginBtn1];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.width.equalTo(@150);
        make.height.equalTo(@40);
        make.centerX.equalTo(self.view);
    }];
    
    [self.loginBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@40);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark -loginBtnClick
- (void)loginBtnClick {
    CTLoginController *loginVC = [CTLoginController new];
    loginVC.displayType = CTLoginDisplayTypePush;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)loginBtnClick1 {
    CTLoginController *loginVC = [CTLoginController new];
    loginVC.displayType = CTLoginDisplayTypePresent;
    CTNavigationController *loginNav = [[CTNavigationController alloc] initWithRootViewController:loginVC];
    // 设置present 全屏
    loginNav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:loginNav animated:YES completion:nil];
}

- (void)goSettings {
    CTSettingsController *settingsVC = [CTSettingsController new];
    [self.navigationController pushViewController:settingsVC animated:YES];
}

@end
