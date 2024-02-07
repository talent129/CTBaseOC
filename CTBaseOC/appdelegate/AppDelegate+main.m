//
//  AppDelegate+main.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/2.
//  Copyright © 2024 CT. All rights reserved.
//

#import "AppDelegate+main.h"
#import "CTLoginController.h"
#import "CTNavigationController.h"
#import "CTTabBarController.h"

@implementation AppDelegate (main)

- (void)setupApp {
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *app = [UINavigationBarAppearance new];
        [app configureWithDefaultBackground];
        app.backgroundColor = [UIColor navigationColor];
        app.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor navigationTitleColor], NSFontAttributeName:[UIFont fontMedium17]};
        app.shadowImage = [UIImage new];
        app.shadowColor = [UIColor clearColor];
        [[UINavigationBar appearance] setScrollEdgeAppearance:app];
        [[UINavigationBar appearance] setStandardAppearance:app];
    }
    
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UICollectionView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //底下这三句是解决mjrefresh 上拉偏移的bug
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    } else {
        // Fallback on earlier versions
        //基类控制器中定义
    }
    
    if (@available(iOS 15.0, *)) {
        [UITableView appearance].sectionHeaderTopPadding = 0;
    }
    
    if (@available(iOS 13.4, *)) {
        [UIDatePicker appearance].preferredDatePickerStyle = UIDatePickerStyleWheels;
    }
    
    self.window = [[UIWindow alloc] initWithFrame:BOUNDS];
    self.window.backgroundColor = [UIColor backgroundColor];
    
    CTTabBarController *tabbar = [[CTTabBarController alloc] init];
    self.window.rootViewController = tabbar;
//    if ([CTUserManager isLogin]) {
//        CTTabBarController *tabbar = [[CTTabBarController alloc] init];
//        self.window.rootViewController = tabbar;
//    } else {
//        CTLoginController *login = [CTLoginController new];
//        CTNavigationController *loginNav = [[CTNavigationController alloc] initWithRootViewController:login];
//        self.window.rootViewController = loginNav;
//    }
    
    [self.window makeKeyAndVisible];
}

@end
