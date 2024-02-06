//
//  CTMD5Encrypt.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/2.
//  Copyright © 2024 CT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMD5Encrypt : NSObject

// MD5加密
/*
 *由于MD5加密是不可逆的,多用来进行验证
 */
// 32位小写
+ (NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+ (NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+ (NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+ (NSString *)MD5ForLower16Bate:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
