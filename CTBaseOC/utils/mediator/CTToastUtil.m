//
//  CTToastUtil.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/2.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTToastUtil.h"
#import "UIView+Toast.h"

@implementation CTToastUtil

+ (void)makeToastCenter:(NSString *)message {
    if (StrEmpty(message)) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self makeToastCenter:message withView:[UIApplication sharedApplication].keyWindow];
    });
}

+ (void)makeToastCenter:(NSString *)message withView:(UIView *)view {
    if (StrEmpty(message) || NilOrNull(view)) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [view makeToast:message duration:2 position:CSToastPositionCenter];
    });
}

@end
