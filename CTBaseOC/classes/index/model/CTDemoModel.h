//
//  CTDemoModel.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/7.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTDemoModel : CTBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;

@end

NS_ASSUME_NONNULL_END
