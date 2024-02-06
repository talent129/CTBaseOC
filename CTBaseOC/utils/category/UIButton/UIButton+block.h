//
//  UIButton+block.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (block)

/// 添加点击回调
/// - Parameter block: 点击回调
- (void)addTargetWithBlock:(void (^)(UIButton *btn))block;

@end

NS_ASSUME_NONNULL_END
