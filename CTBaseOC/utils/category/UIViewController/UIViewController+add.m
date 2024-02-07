//
//  UIViewController+add.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/5.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UIViewController+add.h"

@implementation UIViewController (add)

- (void)addNavigationImageItem:(UIImage *)image
                      withLeft:(BOOL)isLeft
                    withTarget:(id)target
                    withAction:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:action];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    } else {
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)addNavigationTitleItem:(NSString *)title
                     tintColor:(UIColor *)tintColor
                      withLeft:(BOOL)isLeft
                    withTarget:(id)target
                    withAction:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    item.tintColor = tintColor;
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    } else {
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)addCustomNavigationView:(UIView *)view
                       withLeft:(BOOL)isLeft {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    } else {
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)addRightCornerItem:(NSString *)title
                withTarget:(id)target
                withAction:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor themeColor];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = CTScale(12);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor appColorWhite] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontMedium14];
    btn.frame = CGRectMake(0, 0, [CTTool singleLabelRectWithText:title font:[UIFont fontMedium14]].width + 25, CTScale(20));
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)changeNavBarColor:(UIColor *)color {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:color] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)changeNavTitleColor:(UIColor *)color {
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName, [UIFont fontMedium17], NSFontAttributeName, nil]];
}

- (void)changeNavBarColor:(UIColor *)bgColor
            withTextColor:(UIColor *)textColor {
    [self changeNavBarColor:bgColor];
    [self changeNavTitleColor:textColor];
    self.navigationController.navigationBar.tintColor = textColor;
    self.navigationController.navigationBar.barTintColor = textColor;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)showThemeNavBar {
    
}

@end
