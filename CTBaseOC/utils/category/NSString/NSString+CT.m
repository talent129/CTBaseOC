//
//  NSString+CT.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "NSString+CT.h"

@implementation NSString (CT)

///base64编码
+ (NSString *)base64EncodeFromInput:(NSString *)input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

///base64解码
+ (NSString *)base64DecodeFromString:(NSString *)string {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

///是否是6位纯数字
- (BOOL)isSixNumber {
    NSString *num = @"[0-9]{6}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    return [predicate evaluateWithObject:[self lowercaseString]];
}

- (BOOL)isPureInt {
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat {
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isContainChinese:(NSString *)str {
    for(int i = 0; i < [str length]; i++) {
        int a = [str characterAtIndex:i];
        if(a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    } 
    return NO;
}

/// 链接encode
- (NSString *)urlLinkEncode {
    
    if (![NSString isContainChinese:self]) {
        return self;
    }
    
    NSCharacterSet *encode_set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:encode_set];
    return encodedUrl;
}

@end
