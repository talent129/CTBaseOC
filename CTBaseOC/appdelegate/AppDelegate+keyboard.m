//
//  AppDelegate+keyboard.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/2.
//  Copyright © 2024 CT. All rights reserved.
//

#import "AppDelegate+keyboard.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation AppDelegate (keyboard)

- (void)configKeyboard {
    // 键盘遮挡打开 默认打开
    [IQKeyboardManager sharedManager].enable = YES;
    // 输入框区域与键盘距离 默认10
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 0;
    // 不显示键盘上方工具栏 默认显示 -> 不显示
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

@end
