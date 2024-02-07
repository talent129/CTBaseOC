//
//  UIViewController+add.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/5.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (add)

- (void)addNavigationImageItem:(UIImage *)image 
                      withLeft:(BOOL)isLeft
                    withTarget:(id)target
                    withAction:(SEL)action;

- (void)addNavigationTitleItem:(NSString *)title
                     tintColor:(UIColor *)tintColor
                      withLeft:(BOOL)isLeft
                    withTarget:(id)target
                    withAction:(SEL)action;

- (void)addCustomNavigationView:(UIView *)view 
                       withLeft:(BOOL)isLeft;

- (void)addRightCornerItem:(NSString *)title 
                withTarget:(id)target
                withAction:(SEL)action;

- (void)changeNavBarColor:(UIColor *)color;

- (void)changeNavTitleColor:(UIColor *)color;

- (void)changeNavBarColor:(UIColor *)bgColor 
            withTextColor:(UIColor *)textColor;

- (void)showThemeNavBar;

@end

NS_ASSUME_NONNULL_END
