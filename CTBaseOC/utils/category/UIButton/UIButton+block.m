//
//  UIButton+block.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UIButton+block.h"
#import <objc/runtime.h>

typedef void(^BtnTargetBlock)(UIButton *button);
static void *buttonEventBlockKey = &buttonEventBlockKey;

@interface UIButton ()

@property (nonatomic, copy) BtnTargetBlock targetBlock;

@end

@implementation UIButton (block)

- (void)setTargetBlock:(BtnTargetBlock)targetBlock {
    objc_setAssociatedObject(self, &buttonEventBlockKey, targetBlock, OBJC_ASSOCIATION_COPY);
}

- (BtnTargetBlock)targetBlock {
    return objc_getAssociatedObject(self, &buttonEventBlockKey);
}

- (void)addTargetWithBlock:(void (^)(UIButton * _Nonnull))block {
    self.targetBlock = block;
    [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)btn {
    if (self.targetBlock) {
        self.targetBlock(btn);
    }
}

@end
