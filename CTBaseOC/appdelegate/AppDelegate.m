//
//  AppDelegate.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//

#import "AppDelegate.h"
#import "AppDelegate+main.h"
#import "AppDelegate+keyboard.h"
#import "AppDelegate+third.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupApp];
    [self configKeyboard];
    [self configThird];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
    ///清除角标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken API_AVAILABLE(ios(3.0)) {
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken");
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error API_AVAILABLE(ios(3.0)) {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError");
}

@end
