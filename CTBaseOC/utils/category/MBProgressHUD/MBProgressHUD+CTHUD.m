//
//  MBProgressHUD+CTHUD.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "MBProgressHUD+CTHUD.h"
#import "CTTool.h"

@implementation MBProgressHUD (CTHUD)

+ (void)showLoading {
    [MBProgressHUD showLoadingWithView:nil];
}

+ (void)showLoadingWithView:(UIView * _Nullable)container {
    [MBProgressHUD showLoadingWithView:container text:nil];
}

+ (void)showLoadingWithView:(UIView * _Nullable)container text:(NSString * _Nullable)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kTimeOut * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD dismissLoadingWithView:container];
        });
        
        UIView *currentView = container;
        if (!container) {
            currentView = [CTTool getAppDelegate].window;
        }
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
        hud.minSize = CGSizeMake(70, 70);
        hud.userInteractionEnabled = YES; // 禁止交互
        hud.removeFromSuperViewOnHide = YES;
        if (!StrEmpty(text)) {
            hud.label.text = text;
        }
    });
}

+ (void)dismissLoading {
    [self dismissLoadingWithView:nil];
}

+ (void)dismissLoadingWithView:(UIView * _Nullable)container {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *hudView = container;
        if (!container) {
            hudView = [CTTool getAppDelegate].window;
        }
        [MBProgressHUD hideHUDForView:hudView animated:YES];
    });
}

@end
