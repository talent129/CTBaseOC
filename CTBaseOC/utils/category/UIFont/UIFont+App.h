//
//  UIFont+App.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/6.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (App)

//regular
+ (UIFont *)font10;
+ (UIFont *)font11;
+ (UIFont *)font12;
+ (UIFont *)font13;
+ (UIFont *)font14;
+ (UIFont *)font15;
+ (UIFont *)font16;
+ (UIFont *)font17;
+ (UIFont *)font18;
+ (UIFont *)font:(CGFloat)fontSize;

//medium
+ (UIFont *)fontMedium10;
+ (UIFont *)fontMedium11;
+ (UIFont *)fontMedium12;
+ (UIFont *)fontMedium13;
+ (UIFont *)fontMedium14;
+ (UIFont *)fontMedium15;
+ (UIFont *)fontMedium16;
+ (UIFont *)fontMedium17;
+ (UIFont *)fontMedium18;
+ (UIFont *)fontMedium:(CGFloat)fontSize;
+ (UIFont *)fontBold:(CGFloat)fontSize;

+ (UIFont *)tabBarItemFont;
+ (UIFont *)tabBarItemSelectedFont;

@end

NS_ASSUME_NONNULL_END
