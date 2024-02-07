//
//  CTLoginController.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTLoginController.h"
#import <YYText/YYLabel.h>
#import <NSAttributedString+YYText.h>
#import "CTWebController.h"

@interface CTLoginController ()

@property (nonatomic, strong) UIButton *checkedBtn;

@end

@implementation CTLoginController

- (UIButton *)checkedBtn {
    if (!_checkedBtn) {
        _checkedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkedBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [_checkedBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        _checkedBtn.selected = NO;
        _checkedBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 32);
        [_checkedBtn addTarget:self action:@selector(checkedBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkedBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    [self setupUI];
}

- (void)setupUI {
    [super setupUI];
    
    if (self.displayType == CTLoginDisplayTypePresent) {
        [self addNavigationImageItem:[UIImage imageNamed:@"dismiss"] withLeft:YES withTarget:self withAction:@selector(dismiss)];
    }
    
    [self.view addSubview:self.checkedBtn];
    [self.checkedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    NSString *checkedString = @"我同意并愿意遵守App《用户协议》和《隐私政策》测试较长协议文案测试较长协议文案测试较长协议文案测试较长协议文案测试较长协议文案";
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:checkedString];
    [attributed setYy_font:[UIFont fontMedium12]];
    [attributed setYy_color:[UIColor purpleColor]];
    [attributed setYy_alignment:NSTextAlignmentLeft];
    [attributed yy_setTextHighlightRange:NSMakeRange(11, 6) color:[UIColor themeColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        CTWebController *web = [[CTWebController alloc] init];
        web.displayType = CTWebDisplayTypePush;
        web.navigationTitle = @"用户协议";
        web.urlString = @"https://www.baidu.com";
        [self.navigationController pushViewController:web animated:YES];
    }];
    
    [attributed yy_setTextHighlightRange:NSMakeRange(18, 6) color:[UIColor randomColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        CTWebController *web = [[CTWebController alloc] init];
        web.displayType = CTWebDisplayTypePush;
        web.navigationTitle = @"隐私政策";
        web.urlString = @"https://www.baidu.com";
        [self.navigationController pushViewController:web animated:YES];
    }];
    
    YYLabel *checkedL = [[YYLabel alloc] init];
    // 设置preferredMaxLayoutWidth numberOfLines才生效
    checkedL.numberOfLines = 0;
    checkedL.preferredMaxLayoutWidth = SCREEN_Width - 40 - 16 - 5;
    checkedL.attributedText = attributed;
    [self.view addSubview:checkedL];
    [checkedL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.checkedBtn.mas_trailing).offset(-32 + 5);
        make.trailing.mas_equalTo(CTScale(-20));
        make.centerY.equalTo(self.checkedBtn);
    }];
}

- (void)checkedBtnClick {
    self.checkedBtn.selected = !self.checkedBtn.selected;
}

- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
