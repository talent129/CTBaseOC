//
//  UIButton+countDown.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/6.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (countDown)

@property (nonatomic, strong) UIColor *enabledColor;
@property (nonatomic, strong) UIColor *disabledColor;

/// 倒计时按钮
/// @param target target
/// @param selector SEL
+ (instancetype)countDownWithTarget:(id)target sel:(SEL)selector;
- (void)startTime;

@end

NS_ASSUME_NONNULL_END
