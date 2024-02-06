//
//  UIColor+App.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/2.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (App)

+ (UIColor *)themeColor;

// 333333
+ (UIColor *)textColor;

// 666666
+ (UIColor *)secondaryColor;

// 999999
+ (UIColor *)descColor;

// D8D8D8
+ (UIColor *)lineColor;

// white
+ (UIColor *)appColorWhite;

// black
+ (UIColor *)appColorBlack;

// random
+ (UIColor *)randomColor;

+ (UIColor *)navigationColor;

+ (UIColor *)navigationTitleColor;

+ (UIColor *)backgroundColor;

+ (UIColor *)progressColor;

@end

NS_ASSUME_NONNULL_END
