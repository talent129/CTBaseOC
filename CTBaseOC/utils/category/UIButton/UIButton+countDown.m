//
//  UIButton+countDown.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/6.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UIButton+countDown.h"
#import <objc/runtime.h>

static char kEnabledChar;
static char kDisabledChar;

@implementation UIButton (countDown)

- (UIColor *)enabledColor {
    return objc_getAssociatedObject(self, &kEnabledChar);
}

- (void)setEnabledColor:(UIColor *)enabledColor {
    objc_setAssociatedObject(self, &kEnabledChar, enabledColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)disabledColor {
    return objc_getAssociatedObject(self, &kDisabledChar);
}

- (void)setDisabledColor:(UIColor *)disabledColor {
    objc_setAssociatedObject(self, &kDisabledChar, disabledColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (instancetype)countDownWithTarget:(id)target sel:(SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)startTime {
    __block int timeout = 59;
    __weak typeof(self) weakSelfBtn = self;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [weakSelfBtn setTitle:@"重新获取" forState:UIControlStateNormal];
                [weakSelfBtn setTitleColor:NilOrNull(self.enabledColor) ? [UIColor themeColor] : self.enabledColor forState:UIControlStateNormal];
                weakSelfBtn.userInteractionEnabled = YES;
            });
        } else {
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"重新获取(%.2d)", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                [weakSelfBtn setTitle:strTime forState:UIControlStateNormal];
                [weakSelfBtn setTitleColor:NilOrNull(self.disabledColor) ? [UIColor themeColor] : self.disabledColor forState:UIControlStateNormal];
                weakSelfBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
