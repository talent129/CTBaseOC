//
//  CTTool.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTTool : NSObject

///是否开启通知-app
+ (BOOL)isOpenRemoteNotification;

+ (AppDelegate *)getAppDelegate;

+ (BOOL)networkSituation;

+ (UIViewController *)getCurrentController;

+ (UIViewController *)getRootController;

+ (UITabBarController *)getTabBarController;

+ (BOOL)cameraAuthority;

+ (BOOL)albumAuthority;

+ (BOOL)locationAuthority;

/* UserDefault存储,不支持自定义对象 */
+ (void)setObjectValue:(id)obj forKey:(NSString *)key;

+ (id)getObjectValueForKey:(NSString *)key;

//自定义对象
+ (id)getCustomObjectForKey:(NSString *)key;

+ (void)setCustomObject:(id)obj forKey:(NSString *)key;

+ (void)removeValueForKey:(NSString *)key;

+ (CGSize)labelRectWithSize:(CGSize)size
                       text:(NSString *)text
                       font:(UIFont *)font;

+ (CGSize)singleLabelRectWithText:(NSString *)text
                             font:(UIFont *)font;

//对比时间大小
+ (int)compareTwoTime:(NSDate *)firstDate secondDate:(NSDate *)secondDate;

//json to string 序列化
+ (NSString *)jsonToJsonStringWithDict:(NSDictionary *)dict;

//json string to json 反序列化
+ (id)jsonStringToJsonWithString:(NSString *)string;

+ (BOOL)judgePassword:(NSString *)password;

+ (BOOL)checkPhone:(NSString *)num;

+ (NSString *)phoneSecret:(NSString *)phone;

+ (NSMutableArray *)dataArrayWithPlistName:(NSString *)plistName model:(NSString *)modelName;

/**
    读取本地json文件
*/
+ (NSDictionary *)readLocalFileWithName:(NSString *)name;

+ (BOOL)validateIDCardNumber:(NSString *)value;

+ (void)setPlaceHolderWithText:(NSString *)placeHolder textField:(UITextField *)textField leftMargin:(float)leftMargin font:(UIFont *)font color:(UIColor *)color;

+ (UIImage *)getVideoPreViewImageWithPath:(NSURL *)videoPath;

+ (void)playVideo:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
