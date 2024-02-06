//
//  NSString+CT.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CT)

///base64编码
+ (NSString *)base64EncodeFromInput:(NSString *)input;

///base64解码
+ (NSString *)base64DecodeFromString:(NSString *)string;

///是否是6位纯数字
- (BOOL)isSixNumber;

- (BOOL)isPureInt;

- (BOOL)isPureFloat;

/// 判断是否有中文
+ (BOOL)isContainChinese:(NSString *)str;

/// 链接encode
- (NSString *)urlLinkEncode;

@end

NS_ASSUME_NONNULL_END
