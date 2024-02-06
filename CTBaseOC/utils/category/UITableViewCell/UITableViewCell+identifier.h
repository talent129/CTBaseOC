//
//  UITableViewCell+identifier.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/5.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (identifier)

+ (NSString *)cellIdentifier;

- (void)configData:(id)data;
- (void)configData:(id)data indexPath:(NSIndexPath *)indexPath;
- (void)configData:(id)data keypath:(NSString *)keypath;

@end

NS_ASSUME_NONNULL_END
