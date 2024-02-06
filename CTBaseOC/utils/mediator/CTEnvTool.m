//
//  CTEnvTool.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTEnvTool.h"

@implementation CTEnvTool

SingletonM(CTEnvTool);

- (void)changeEnv:(BOOL)isDev {
    [[NSUserDefaults standardUserDefaults] setBool:isDev forKey:kAppEnv];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)currentEnv {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kAppEnv];;
}

@end
