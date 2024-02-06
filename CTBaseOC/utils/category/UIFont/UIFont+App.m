//
//  UIFont+App.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/6.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UIFont+App.h"

@implementation UIFont (App)

+ (UIFont *)tabBarItemFont { //缩放大小 会导致 push后 再返回 tabbaritem文字显示不全
    return [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
}

+ (UIFont *)tabBarItemSelectedFont {
    return [UIFont systemFontOfSize:10 weight:UIFontWeightBold];
}

//regular
+ (UIFont *)font:(CGFloat)fontSize {
    CGFloat width = MIN([UIScreen mainScreen].bounds.size.height,  [UIScreen mainScreen].bounds.size.width);
    return [UIFont systemFontOfSize:(fontSize * (width/375.0))];
}

+ (UIFont *)font10 {
    return [UIFont font:10];
}

+ (UIFont *)font11 {
    return [UIFont font:11];
}

+ (UIFont *)font12 {
    return [UIFont font:12];
}

+ (UIFont *)font13 {
    return [UIFont font:13];
}

+ (UIFont *)font14 {
    return [UIFont font:14];
}

+ (UIFont *)font15 {
    return [UIFont font:15];
}

+ (UIFont *)font16 {
    return [UIFont font:16];
}

+ (UIFont *)font17 {
    return [UIFont font:17];
}

+ (UIFont *)font18 {
    return [self font:18];
}

+ (UIFont *)fontMedium:(CGFloat)fontSize {
    CGFloat width = MIN([UIScreen mainScreen].bounds.size.height,  [UIScreen mainScreen].bounds.size.width);
    return [UIFont systemFontOfSize:(fontSize * (width/375.0)) weight:UIFontWeightMedium];
}

+ (UIFont *)fontMedium10 {
    return [UIFont fontMedium:10];
}

+ (UIFont *)fontMedium11 {
    return [UIFont fontMedium:11];
}

+ (UIFont *)fontMedium12 {
    return [UIFont fontMedium:12];
}

+ (UIFont *)fontMedium13 {
    return [UIFont fontMedium:13];
}

+ (UIFont *)fontMedium14 {
    return [UIFont fontMedium:14];
}

+ (UIFont *)fontMedium15 {
    return [UIFont fontMedium:15];
}

+ (UIFont *)fontMedium16 {
    return [UIFont fontMedium:16];
}

+ (UIFont *)fontMedium17 {
    return [UIFont fontMedium:17];
}

+ (UIFont *)fontMedium18 {
    return [UIFont fontMedium:18];
}

+ (UIFont *)fontBold:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightBold];
}

@end
