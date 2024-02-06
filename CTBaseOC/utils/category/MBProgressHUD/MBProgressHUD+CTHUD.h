//
//  MBProgressHUD+CTHUD.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (CTHUD)

+ (void)showLoading;
+ (void)showLoadingWithView:(UIView * _Nullable)container;
+ (void)showLoadingWithView:(UIView * _Nullable)container text:(NSString * _Nullable)text;

+ (void)dismissLoading;
+ (void)dismissLoadingWithView:(UIView * _Nullable)container;

@end

NS_ASSUME_NONNULL_END
