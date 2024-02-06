//
//  UIColor+App.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/2.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UIColor+App.h"

@implementation UIColor (App)

+ (UIColor *)themeColor {
    return [UIColor colorWithHexString:@"#FFB000"];
}

// 333333
+ (UIColor *)textColor {
    return [UIColor colorWithHexString:@"#333333"];
}

// 666666
+ (UIColor *)secondaryColor {
    return [UIColor colorWithHexString:@"#666666"];
}

// 999999
+ (UIColor *)descColor {
    return [UIColor colorWithHexString:@"#999999"];
}

// D8D8D8
+ (UIColor *)lineColor {
    return [UIColor colorWithHexString:@"#D8D8D8"];
}

// white
+ (UIColor *)appColorWhite {
    return [UIColor colorWithHexString:@"#FFFFFF"];
}

// black
+ (UIColor *)appColorBlack {
    return [UIColor colorWithHexString:@"#000000"];
}

// random
+ (UIColor *)randomColor {
    CGFloat red = arc4random_uniform(256)/ 255.0;
    CGFloat green = arc4random_uniform(256)/ 255.0;
    CGFloat blue = arc4random_uniform(256)/ 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)navigationColor {
    return [UIColor colorWithHexString:@"#55A3F2"];
}

+ (UIColor *)navigationTitleColor {
    return [UIColor appColorWhite];
}

+ (UIColor *)backgroundColor {
    return [UIColor colorWithHexString:@"#F4F5F6"];
}

+ (UIColor *)progressColor {
    return [UIColor themeColor];
}

@end
