//
//  UIImage+CT.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/6.
//  Copyright © 2024 CT. All rights reserved.
//

/*
 使用:
 [self.navigationBar setBackgroundImage:[UIImage gradientColorImageFromColors:@[ZJSCOLOR(@"#34a3d9"),ZJSCOLOR(@"#318cd0"),ZJSCOLOR(@"#2f82cd")] gradientType:GradientTypeUpleftToLowright imgSize:CGSizeMake(600, 120)] forBarMetrics:UIBarMetricsDefault];
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到下
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (CT)

+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;

//用颜色创建一张图片
+ (instancetype)createImageWithColor:(UIColor *)color;

//用颜色创建一张图片
+ (instancetype)createImageWithColor:(UIColor *)color size:(CGSize)size;

/// 图片圆角 实例方法
- (instancetype)circleImage;

/// 图片圆角 类方法
/// @param image 图片名
+ (instancetype)circleImage:(NSString *)image;

/// 压缩图片到指定大小
/// @param maxLength 指定大小
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength;

- (void)savedPhotosAlbum;

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size;
- (UIImage *)scaleImageToSize:(CGSize)size;
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

- (UIImage *)addWatermarkWithTime:(NSString *)time name:(NSString *)name address:(NSString *)address;

- (UIImage *)addTextToImageWithFirstText:(NSString *)firstText secondText:(NSString *)secondText;

@end

NS_ASSUME_NONNULL_END
