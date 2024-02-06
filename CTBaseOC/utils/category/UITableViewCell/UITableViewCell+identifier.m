//
//  UITableViewCell+identifier.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/5.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UITableViewCell+identifier.h"

@implementation UITableViewCell (identifier)

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

- (void)configData:(id)data {}
- (void)configData:(id)data indexPath:(NSIndexPath *)indexPath {}
- (void)configData:(id)data keypath:(NSString *)keypath {}

@end
