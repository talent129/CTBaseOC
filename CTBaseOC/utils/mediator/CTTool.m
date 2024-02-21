//
//  CTTool.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTTool.h"
#import <Reachability/Reachability.h>
#import <AVFoundation/AVCaptureDevice.h> // 相机权限
#import <Photos/PHPhotoLibrary.h> // 相册权限
#import <CoreLocation/CoreLocation.h> // 位置权限
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@implementation CTTool

///是否开启通知-app
+ (BOOL)isOpenRemoteNotification {
    return !([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone);
}

+ (AppDelegate *)getAppDelegate {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate;
}

+ (BOOL)networkSituation {
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    return status != NotReachable;
}

+ (UIViewController *)getCurrentController {
    return [self topViewControllerWithRootViewController:[CTTool getRootController]];
}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else if ([rootViewController isKindOfClass:[RTContainerController class]]) {
        RTContainerController *containerVC = (RTContainerController *)rootViewController;
        return containerVC.contentViewController;
    } else {
        return (UIViewController *)rootViewController;
    }
}

+ (UIViewController *)getRootController {
    return [CTTool getAppDelegate].window.rootViewController;
}

+ (UITabBarController *)getTabBarController {
    if ([[self getRootController] isKindOfClass:[UITabBarController class]]) {
        return (UITabBarController *)[self getRootController];
    } else {
        return nil;
    }
}

+ (BOOL)cameraAuthority {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

+ (BOOL)albumAuthority {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        return NO;
    }
    if (status == PHAuthorizationStatusNotDetermined) {
        //有时不会弹出系统请求相册权限提示框 这里调起系统提示框
        [self requestAuthorizationWithCompletion:nil];
    }
    return YES;
}

+ (void)requestAuthorizationWithCompletion:(void (^)(void))completion {
    void (^callCompletionBlock)(void) = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            callCompletionBlock();
        }];
    });
}

+ (BOOL)locationAuthority {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if ([CLLocationManager locationServicesEnabled] && (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted)) {
        return NO;
    }
    return YES;
}

/* UserDefault存储,不支持自定义对象 */
+ (void)setObjectValue:(id)obj forKey:(NSString *)key {
    [self removeValueForKey:key];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:obj forKey:key];
    [userDefault synchronize];
}

+ (id)getObjectValueForKey:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    id value = [userDefault objectForKey:key];
    return value;
}

//自定义对象
+ (id)getCustomObjectForKey:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefault objectForKey:key];
    
    // 从二进制流读取对象
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return object;
}

+ (void)setCustomObject:(id)obj forKey:(NSString *)key {
    // 把对象写到二进制流中
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [self removeValueForKey:key];
    [userDefault setObject:data forKey:key];
    [userDefault synchronize];
}

+ (void)removeValueForKey:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:key];
    [userDefault synchronize];
}

+ (CGSize)labelRectWithSize:(CGSize)size
                       text:(NSString *)text
                       font:(UIFont *)font {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGSize rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return rect;
}

+ (CGSize)singleLabelRectWithText:(NSString *)text
                             font:(UIFont *)font {
    return [text sizeWithAttributes:@{NSFontAttributeName: font}];
}

//对比时间大小
+ (int)compareTwoTime:(NSDate *)firstDate secondDate:(NSDate *)secondDate {
    NSComparisonResult result = [firstDate compare:secondDate];
    if (result == NSOrderedSame) {
        return 0; //相等
    }
    if (result == NSOrderedAscending) {
        return 1; //secondDate大
    }
    return 2; //firstDate大
}

//json to string 序列化
+ (NSString *)jsonToJsonStringWithDict:(NSDictionary *)dict {
    BOOL can = [NSJSONSerialization isValidJSONObject:dict];
    if (can) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:(NSJSONWritingPrettyPrinted) error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        return jsonString;
    } else {
        return nil;
    }
}

//json string to json 反序列化
+ (id)jsonStringToJsonWithString:(NSString *)string {
    if (string == nil) {
        return nil;
    }
    /**
     NSJSONReadingMutableContainers:
     返回的数组和字典都是 NSMutableArray 和 NSMutableDictionay 类型，固可以作后续修改。
     NSJSONReadingMutableLeaves:
     返回的的字符串是 NSMutableSting 类型，这里实践后是不行的，网上查了很多资料说是苹果的 bug，到目前 iOS8 中也没有修复。
     NSJSONReadingAllowFragments:
     需要格式化的 json 字符串最外层可以不是数组和字典，只要是正确的 json 格式就行
     */
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
    if (error) {
        NSLog(@"解析失败: %@", error);
        return nil;
    }
    return obj;
}

+ (BOOL)judgePassword:(NSString *)password {
    // 验证密码长度
    if(password.length < 8 || password.length > 16) {
        NSLog(@"请输入8-16的密码");
        return NO;
    }
     // 验证密码是否包含数字
     NSString *numPattern = @".*\\d+.*";
     NSPredicate *numPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numPattern];
     if (![numPred evaluateWithObject:password]) {
         NSLog(@"密码必须包含数字");
         return NO;
     }
    
     // 验证密码是否包含小写字母
     NSString *lowerPattern = @".*[a-z]+.*";
     NSPredicate *lowerPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", lowerPattern];
     if (![lowerPred evaluateWithObject:password]) {
         NSLog(@"密码必须包含小写字母");
         return NO;
     }
    
     // 验证密码是否包含大写字母
     NSString *upperPattern = @".*[A-Z]+.*";
     NSPredicate *upperPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", upperPattern];
     if (![upperPred evaluateWithObject:password]) {
         NSLog(@"密码必须包含大写字母");
         return NO;
     }
     return YES;
}

+ (BOOL)checkPhone:(NSString *)num {
    return (num.length == 11);
}

+ (NSString *)phoneSecret:(NSString *)phone {
    if (phone.length == 11) {
        phone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    return phone;
}

#pragma mark -传入plist文件名 与 model名 -获取model数组
/**
 传入plist文件名 与 model名 获取model数组
 @param plistName plist文件名
 @param modelName model名
 @return model数组
 */
+ (NSMutableArray *)dataArrayWithPlistName:(NSString *)plistName model:(NSString *)modelName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSArray *teamArray = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dic in teamArray) {
        
        Class class = NSClassFromString(modelName);
        id item = [[class alloc] init];
        
        [item setValuesForKeysWithDictionary:dic];
        [items addObject:item];
    }
    return items;
}

/**
    读取本地json文件
*/
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!value) {
        return NO;
    } else {
        length = value.length;
        //不满足15位和18位，即身份证错误
        if (length != 15 && length != 18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    // 检测省份身份行政区代码
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    //分为15位、18位身份证进行校验
    switch (length) {
        case 15:
            //获取年份对应的数字
            year = [value substringWithRange:NSMakeRange(6, 2)].intValue + 1900;
            if (year %4 == 0 || (year %100 == 0 && year %4 == 0)) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];
            } else {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"options:NSRegularExpressionCaseInsensitive error:nil];
            }
            //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if (numberofMatch > 0) {
                return YES;
            } else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6, 4)].intValue;
            if (year %4 == 0 || (year %100 == 0 && year %4 == 0)) {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];
            } else {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            
            if (numberofMatch > 0) {
                //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                int S = [value substringWithRange:NSMakeRange(0, 1)].intValue * 7 + [value substringWithRange:NSMakeRange(10, 1)].intValue * 7 + [value substringWithRange:NSMakeRange(1, 1)].intValue * 9 + [value substringWithRange:NSMakeRange(11, 1)].intValue * 9 + [value substringWithRange:NSMakeRange(2, 1)].intValue * 10 + [value substringWithRange:NSMakeRange(12, 1)].intValue * 10 + [value substringWithRange:NSMakeRange(3, 1)].intValue * 5 + [value substringWithRange:NSMakeRange(13, 1)].intValue * 5 + [value substringWithRange:NSMakeRange(4, 1)].intValue * 8 + [value substringWithRange:NSMakeRange(14, 1)].intValue * 8 + [value substringWithRange:NSMakeRange(5, 1)].intValue * 4 + [value substringWithRange:NSMakeRange(15,1)].intValue * 4 + [value substringWithRange:NSMakeRange(6, 1)].intValue * 2 + [value substringWithRange:NSMakeRange(16, 1)].intValue * 2 + [value substringWithRange:NSMakeRange(7, 1)].intValue * 1 + [value substringWithRange:NSMakeRange(8, 1)].intValue * 6 + [value substringWithRange:NSMakeRange(9, 1)].intValue * 3;
                //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                int Y = S %11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                //3：获取校验位
                M = [JYM substringWithRange:NSMakeRange(Y, 1)];
                NSString *lastStr = [value substringWithRange:NSMakeRange(17, 1)];
                NSLog(@"%@",M);
                NSLog(@"%@",[value substringWithRange:NSMakeRange(17, 1)]);
                //4：检测ID的校验位
                if ([lastStr isEqualToString:@"x"]) {
                    if ([M isEqualToString:@"X"]) {
                        return YES;
                    } else {
                        return NO;
                    }
                } else {
                    if ([M isEqualToString:[value substringWithRange:NSMakeRange(17, 1)]]) {
                        return YES;
                    } else {
                        return NO;
                    }
                }
            } else {
                return NO;
            }
        default:
            return NO;
    }
}

+ (void)setPlaceHolderWithText:(NSString *)placeHolder textField:(UITextField *)textField leftMargin:(float)leftMargin font:(UIFont *)font color:(UIColor *)color {
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:placeHolder];
    [placeholderString addAttribute:NSForegroundColorAttributeName
                        value:color
                        range:NSMakeRange(0, placeHolder.length)];
    [placeholderString addAttribute:NSFontAttributeName
                        value:font
                        range:NSMakeRange(0, placeHolder.length)];
    textField.attributedPlaceholder = placeholderString;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftMargin, 26)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

//获取视频的第一帧截图, 返回UIImage (需要导入AVFoundation.h)
+ (UIImage *)getVideoPreViewImageWithPath:(NSURL *)videoPath {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoPath options:nil];
    
    AVAssetImageGenerator *gen         = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time      = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error   = nil;
    
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img     = [[UIImage alloc] initWithCGImage:image];
    
    return img;
}

+ (void)playVideo:(NSURL *)url {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 2. 创建视频播放控制器
        AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
        // 3. 设置视频播放器 (这里为了简便,使用了URL方式,同样支持playerWithPlayerItem:的方式)
        playerViewController.player = [AVPlayer playerWithURL:url];
        // 4. modal展示
        [[CTTool getCurrentController] presentViewController:playerViewController animated:YES completion:nil];
        // 5. 开始播放 : 默认不会自动播放
        [playerViewController.player play];
    });
}

@end
