//
//  CTToastUtil.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/2.
//  Copyright © 2024 CT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTToastUtil : NSObject

/// window上toast
+ (void)makeToastCenter:(NSString *)message;

+ (void)makeToastCenter:(NSString *)message withView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
