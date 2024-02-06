//
//  AES128Util.h
//  xzark
//
//  Created by Curtis on 2022/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AES128Util : NSObject

+ (NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;

+ (NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
