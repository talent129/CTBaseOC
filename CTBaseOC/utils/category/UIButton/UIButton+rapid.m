//
//  UIButton+rapid.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/5.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UIButton+rapid.h"

@implementation UIButton (rapid)

+ (instancetype)themeBtn {
    return [UIButton btnWithBGColor:[UIColor themeColor] tag:-1 radius:CTScale(10) title:nil titleColor:nil fontSize:CTScale(16)];
}

+ (instancetype)randomBtn {
    return [UIButton btnWithBGColor:[UIColor randomColor] tag:-1 radius:CTScale(10) title:@"btn" titleColor:[UIColor randomColor] fontSize:CTScale(16)];
}

/// 创建按钮
/// - Parameters:
///   - bgColor: 按钮背景色
///   - tag: 按钮tag
///   - radius: 按钮圆角
///   - title: 按钮文字
///   - titleColor: 按钮文字颜色
///   - fontSize: 按钮文字大小
+ (instancetype)btnWithBGColor:(UIColor * _Nullable)bgColor
                           tag:(NSInteger)tag
                        radius:(CGFloat)radius
                         title:(NSString * _Nullable)title
                    titleColor:(UIColor * _Nullable)titleColor
                      fontSize:(CGFloat)fontSize {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = bgColor;
    if (tag >= 0) {
        btn.tag = tag;
    }
    if (radius > 0) {
        [btn setCornerRadius:radius];
    }
    if (!StrEmpty(title)) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (fontSize > 0) {
        btn.titleLabel.font = [UIFont font:fontSize];
    }
    return btn;
}

+ (instancetype)cornerBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn applyStyle];
    return btn;
}

- (void)applyStyle {
    self.layer.cornerRadius = CTScale(10);
    self.layer.masksToBounds = YES;
    self.titleLabel.font = [UIFont font16];
    [self setTitleColor:[UIColor appColorWhite] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:1 alpha:0.7] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage createImageWithColor:[UIColor themeColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage createImageWithColor:[UIColor themeColor]] forState:UIControlStateHighlighted];
}

@end
