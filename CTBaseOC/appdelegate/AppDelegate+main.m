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

@implementation AppDelegate (main)

- (void)setupApp {
    self.window = [[UIWindow alloc] initWithFrame:BOUNDS];
    self.window.backgroundColor = [UIColor orangeColor];
    
    CTLoginController *login = [CTLoginController new];
    CTNavigationController *loginNav = [[CTNavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = loginNav;
    [self.window makeKeyAndVisible];
}

@end
