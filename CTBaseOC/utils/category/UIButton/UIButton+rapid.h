//
//  UIButton+rapid.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/5.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (rapid)

+ (instancetype)themeBtn;

+ (instancetype)randomBtn;

+ (instancetype)cornerBtn;

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
                      fontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
