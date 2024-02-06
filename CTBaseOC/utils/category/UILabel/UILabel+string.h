//
//  UILabel+string.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/6.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (string)

/// 设置文本和行间距
/// @param text 文本
/// @param lineSpacing 行间距
- (void)setText:(NSString *)text
    lineSpacing:(CGFloat)lineSpacing;

/// 创建label/默认单行
/// @param font font description
/// @param textColor textColor description
/// @param alignment alignment description
+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                    alignment:(NSTextAlignment)alignment;

/// 创建label/默认单行
/// @param font font description
/// @param textColor textColor description
/// @param alignment alignment description
/// @param text text description
+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                    alignment:(NSTextAlignment)alignment
                         text:(NSString *)text;

/// 创建label
/// @param font font description
/// @param textColor textColor description
/// @param alignment alignment description
/// @param numberOfLine numberOfLine description
/// @param backgroundColor backgroundColor description
+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                    alignment:(NSTextAlignment)alignment
                 numberOfLine:(NSUInteger)numberOfLine
              backgroundColor:(UIColor *)backgroundColor;


+ (NSArray <NSString *> *)getLinesArrayOfLabelRows:(CGFloat)labelWidth
                                              text:(NSString *)text
                                              font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
