//
//  CTUserManager.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTUserManager : NSObject

/// 登录状态
+ (BOOL)isLogin;

/// token
+ (NSString *)getToken;
+ (void)setToken:(NSString *)token;

+ (CTUserModel *)getUserInfo;
+ (void)setUserInfo:(CTUserModel *)model;

+ (NSString *)getLoginPhone;
+ (void)saveLoginPhone:(NSString *)phone;

/// 退出登录 注销时调用
+ (void)clearInfo;

@end

NS_ASSUME_NONNULL_END
