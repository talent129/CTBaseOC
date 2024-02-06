//
//  CTEnvTool.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTEnvTool : NSObject

SingletonH(CTEnvTool);

- (void)changeEnv:(BOOL)isDev;
- (BOOL)currentEnv;

@end

NS_ASSUME_NONNULL_END
