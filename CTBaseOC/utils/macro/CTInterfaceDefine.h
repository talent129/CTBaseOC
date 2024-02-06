//
//  CTInterfaceDefine.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//  接口

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTInterfaceDefine : NSObject

/// 环境开关
extern NSString *const SERVER_HOST_Dev;
extern NSString *const SERVER_HOST_Pro;

/// html baseUrl
extern NSString *const SERVER_HOST_HTML_Dev;
extern NSString *const SERVER_HOST_HTML_Pro;

extern NSString *const APP_APPSTORE_URL;

/******************************************************版本管理****************************************************/



/******************************************************登录****************************************************/

///登录
extern NSString *const kLoginByPwd;

///退出登录
extern NSString *const kLogOut;


/******************************************************公共****************************************************/



@end

NS_ASSUME_NONNULL_END
