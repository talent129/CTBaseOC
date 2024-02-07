//
//  CTWebController.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/7.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTWebController : CTBaseController

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *navigationTitle;

@end

NS_ASSUME_NONNULL_END
