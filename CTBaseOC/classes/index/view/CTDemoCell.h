//
//  CTDemoCell.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/7.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CTDemoModel;
@interface CTDemoCell : UITableViewCell

@property (nonatomic, strong) CTDemoModel *model;

@end

NS_ASSUME_NONNULL_END
