//
//  UIView+ext.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/5.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ext)

/** x */
@property (nonatomic, assign) CGFloat x;
/** y */
@property (nonatomic, assign) CGFloat y;
/** width */
@property (nonatomic, assign) CGFloat width;
/** height */
@property (nonatomic, assign) CGFloat height;
/** centerX */
@property (nonatomic, assign) CGFloat centerX;
/** centerY */
@property (nonatomic, assign) CGFloat centerY;
/** right */
@property (nonatomic, assign) CGFloat right;
/** bottom */
@property (nonatomic, assign) CGFloat bottom;
/** size */
@property (nonatomic, assign) CGSize size;

/// 设置圆角
/// - Parameter cornerRadius: 圆角值
- (void)setCornerRadius:(CGFloat)cornerRadius;

/// 圆形
- (void)circleCorner;

/// 设置边框
/// - Parameters:
///   - color: 边框色
///   - width: 边框宽度
- (void)setBorder:(UIColor *)color width:(CGFloat)width;

/// 可视化获取视图
+ (instancetype)viewForNib;

/// 默认圆角阴影样式图 ，圆角为5
+ (instancetype)appCornerShadowThemeView;

/// 默认圆角阴影样式图
/// @param radius 圆角大小
+ (instancetype)appCornerShadowThemeViewWithCornerRadius:(CGFloat)radius;

/// app内通用的阴影样式
- (void)setAppShadowStyle;

/// 添加圆角
/// @param corners 圆角方位
/// @param rRadii 圆角大小
/// @param shadowLayer shadow层绘制
- (void)addCorners:(UIRectCorner)corners
            rRadii:(CGFloat)rRadii
       shadowLayer:(nullable void (^)(CALayer * shadowLayer))shadowLayer;

@end

NS_ASSUME_NONNULL_END
