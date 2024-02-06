//
//  UIImage+CT.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/6.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UIImage+CT.h"

@implementation UIImage (CT)

//用颜色创建一张图片
+ (instancetype)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)createImageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    
    return image;
}

/// 图片圆角 实例方法
- (instancetype)circleImage {
    UIGraphicsBeginImageContext(self.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/// 图片圆角 类方法
/// @param image 图片名
+ (instancetype)circleImage:(NSString *)image {
    return [[self imageNamed:image] circleImage];
}

#pragma mark 压缩图片
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength {
    CGFloat maxByte = maxLength * 1024.f;
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxByte) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxByte * 0.9) {
            min = compression;
        } else if (data.length > maxByte) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}

- (void)savedPhotosAlbum {
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge  void*)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width < size.width) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *nImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return nImage;
}

- (UIImage *)scaleImageToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *nImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return nImage;
}

+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    
    //将UIImage转换成CGImageRef
    CGImageRef ref = [image CGImage];
    //按照给定的矩形区域进行剪裁
    CGImageRef nRef = CGImageCreateWithImageInRect(ref, rect);
    //将CGImageR而非转换成UIImage
    UIImage *nImage = [UIImage imageWithCGImage:nRef];
    //返回剪裁后的图片
    return nImage;
}

- (UIImage *)addWatermarkWithTime:(NSString *)time name:(NSString *)name address:(NSString *)address {
    UIGraphicsBeginImageContext(self.size);
    [self drawAtPoint:CGPointMake(0, 0)];
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextDrawPath(ref, kCGPathStroke);
    
    [time drawAtPoint:CGPointMake(30, self.size.height - 160) withAttributes:@{NSFontAttributeName: [UIFont font:30], NSForegroundColorAttributeName: [UIColor themeColor]}];
    
    [name drawAtPoint:CGPointMake(30, self.size.height - 120) withAttributes:@{NSFontAttributeName: [UIFont font:30], NSForegroundColorAttributeName: [UIColor themeColor]}];
    
    [address drawInRect:CGRectMake(30, self.size.height - 80, self.size.width - 60, 70) withAttributes:@{NSFontAttributeName: [UIFont font:30], NSForegroundColorAttributeName: [UIColor themeColor]}];
    UIImage *nImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return nImage;
}

- (UIImage *)addTextToImageWithFirstText:(NSString *)firstText secondText:(NSString *)secondText {
    UIGraphicsBeginImageContext(self.size);
    [self drawAtPoint:CGPointMake(0, 0)];
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextDrawPath(ref, kCGPathStroke);
    
    CGFloat h = 20;
    CGFloat firstW = [CTTool labelRectWithSize:CGSizeMake(CGFLOAT_MAX, h) text:firstText font:[UIFont font:18]].width;
    CGFloat secondW = [CTTool singleLabelRectWithText:secondText font:[UIFont font18]].width;
    
    [firstText drawInRect:CGRectMake(self.size.width - firstW - 10, self.size.height - h*2 - 10, self.size.width, h) withAttributes:@{NSFontAttributeName: [UIFont font18], NSForegroundColorAttributeName: [UIColor randomColor]}];
    [secondText drawInRect:CGRectMake(self.size.width - secondW - 10, self.size.height - h - 5, self.size.width, h) withAttributes:@{NSFontAttributeName: [UIFont font18], NSForegroundColorAttributeName: [UIColor randomColor]}];
    UIImage *nImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return nImage;
}

+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize {
    
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    
    switch (gradientType) {
            
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case GradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case GradientTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
