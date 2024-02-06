//
//  UIColor+hex.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/2.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (hex)

+ (UIColor *)colorWithHex:(unsigned int)hex;

+ (UIColor *)colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;

/**
 *  十进制转颜色,[UIColor colorWithDecimalRed:12 green:12 blue:12 alpha:1]
 *
 *  @param red   r
 *  @param green g
 *  @param blue  b
 *  @param alpha a
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithDecimalRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

/**
 *  十六进制转颜色 [UIColor colorWithHexString:@"#CC00FF" alpha:1]
 *
 *  @param hexString 十六进制字符串
 *  @param alpha     a
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
