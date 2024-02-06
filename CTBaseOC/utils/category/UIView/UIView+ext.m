//
//  UIView+ext.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/5.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UIView+ext.h"

@implementation UIView (ext)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

/// 设置圆角
/// - Parameter cornerRadius: 圆角值
- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

/// 圆形
- (void)circleCorner {
    [self setCornerRadius:self.height*0.5];
}

/// 设置边框
/// - Parameters:
///   - color: 边框色
///   - width: 边框宽度
- (void)setBorder:(UIColor *)color width:(CGFloat)width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

/// 可视化获取视图
+ (instancetype)viewForNib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

/// 默认圆角阴影样式图 ，圆角为5
+ (instancetype)appCornerShadowThemeView {
    return [self appCornerShadowThemeViewWithCornerRadius:5];
}

/// 默认圆角阴影样式图
/// @param radius 圆角大小
+ (instancetype)appCornerShadowThemeViewWithCornerRadius:(CGFloat)radius {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor appColorWhite];
    [view setAppShadowStyle];
    [view setCornerRadius:radius];
    return view;
}

/// app内通用的阴影样式
- (void)setAppShadowStyle {
    self.layer.shadowColor = [UIColor colorWithRed:112/255.0 green:112/255.0 blue:112/255.0 alpha:0.1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,2);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 5;
    self.layer.cornerRadius = 6;
}

/// 添加圆角
/// @param corners 圆角方位
/// @param rRadii 圆角大小
/// @param shadowLayer shadow层绘制
- (void)addCorners:(UIRectCorner)corners
            rRadii:(CGFloat)rRadii
       shadowLayer:(nullable void (^)(CALayer * shadowLayer))shadowLayer {
    UIView *aview = self;
    CGSize cornerRadii = CGSizeMake(rRadii, rRadii);
    
    //前面的裁剪
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = [UIBezierPath bezierPathWithRoundedRect:aview.bounds
    byRoundingCorners:corners cornerRadii:cornerRadii].CGPath;
    aview.layer.mask = mask;
   
    //后面的那个
    if(!aview.superview) return;
    UIView * draftView = [[UIView alloc] initWithFrame:aview.frame];
    draftView.backgroundColor = aview.backgroundColor;
    [aview.superview insertSubview:draftView belowSubview:aview];
    
    if(shadowLayer){
        shadowLayer(draftView.layer);
    }else{
        draftView.layer.shadowOpacity = 0.25;
        draftView.layer.shadowOffset = CGSizeZero;
        draftView.layer.shadowRadius = 10;
    }
    
    draftView.backgroundColor = nil;
    draftView.layer.masksToBounds = NO;
    
    CALayer *cornerLayer = [CALayer layer];
    cornerLayer.frame = draftView.bounds;
    cornerLayer.backgroundColor = aview.backgroundColor.CGColor;

    CAShapeLayer *lay = [CAShapeLayer layer];
    lay.path = [UIBezierPath bezierPathWithRoundedRect:aview.bounds
    byRoundingCorners:corners cornerRadii:cornerRadii].CGPath;
    cornerLayer.mask = lay;
    [draftView.layer addSublayer:cornerLayer];
}

@end
