//
//  UICollectionViewCell+identifier.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/6.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UICollectionViewCell+identifier.h"

@implementation UICollectionViewCell (identifier)

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

@end
