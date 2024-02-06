//
//  CTUserManager.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTUserManager.h"

@implementation CTUserManager

/// 登录状态
+ (BOOL)isLogin {
    return !StrEmpty([CTUserManager getToken]) && !NilOrNull([CTUserManager getUserInfo]);
}

/// token
+ (NSString *)getToken {
    NSString *token = [CTTool getObjectValueForKey:kTokenKey];
    return token;
}

+ (void)setToken:(NSString *)token {
    if (StrEmpty(token)) {
        return;
    }
    [CTTool setObjectValue:token forKey:kTokenKey];
}

+ (CTUserModel *)getUserInfo {
    CTUserModel *user = [CTTool getCustomObjectForKey:kUserKey];
    return user;
}

+ (void)setUserInfo:(CTUserModel *)model {
    if (NilOrNull(model)) {
        return;
    }
    [CTTool setCustomObject:model forKey:kUserKey];
}

+ (NSString *)getLoginPhone {
    NSString *phone = [CTTool getObjectValueForKey:kLoginPhoneKey];
    return phone;
}

+ (void)saveLoginPhone:(NSString *)phone {
    if (StrEmpty(phone)) {
        return;
    }
    [CTTool setObjectValue:phone forKey:kLoginPhoneKey];
}

/// 退出登录 注销时调用
+ (void)clearInfo {
    [CTTool removeValueForKey:kUserKey];
    [CTTool removeValueForKey:kTokenKey];
    [CTTool removeValueForKey:kLoginPhoneKey];
}

@end
