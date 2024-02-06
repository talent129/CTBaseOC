//
//  CTPublicDefine.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//  常用宏定义

#ifndef CTPublicDefine_h
#define CTPublicDefine_h

/* 字符串是否为空 */
#define StrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
/* 是否为空或是[NSNull null] */
#define NilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isEqual:@"null"]) || ([(_ref) isEqual:@"(null)"]))
// 是否空数组
#define ArrEmpty(_ref) (((_ref) == nil) || (![(_ref) isKindOfClass:[NSArray class]]) || ((_ref).count == 0))

/**
 *设置rgb颜色
 *@prame a 透明度
 */
#define RGBA(r,g,b,a)      [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

/* 常用frame */
#define BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_Width    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_Height   ([UIScreen mainScreen].bounds.size.height)

// 375设计稿比例
#define CTScale(X) (X) * (SCREEN_Width/375.0)

/* app页面相关尺寸 */
#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)
#define kNavBarHeight (kStatusBarHeight + 44.0)
#define kBottomSafeAreaHeight (kTabBarHeight - 49)
#define kIsIPhoneX (kStatusBarHeight > 20 ? YES : NO)

#define _CGP(x, y)                                      CGPointMake(x, y)
#define _CGS(w, h)                                      CGSizeMake(w, h)
#define _CGR(x, y, w, h)                                CGRectMake(x, y, w, h)

//block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

/* app版本号 */
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/* app build */
#define kAppBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/* app 名称 */
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/* 系统版本号 */
#define kSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否为iPhone 返回BOOL类型
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad 返回BOOL类型
#define kISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()

//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define VIDEOCACHEPATH [NSTemporaryDirectory() stringByAppendingPathComponent:@"videoCache"]

// 单例
// .h文件
#define SingletonH(name) + (instancetype)shared##name;

// .m文件
#define SingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

//在Main线程上运行
#define DISPATCH_ON_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

/* 显示打印行 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif /* CTPublicDefine_h */
