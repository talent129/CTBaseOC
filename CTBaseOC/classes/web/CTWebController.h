//
//  CTWebController.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/7.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTBaseController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CTWebDisplayType) {
    CTWebDisplayTypePush,
    CTWebDisplayTypePresent
};

@interface CTWebController : CTBaseController

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *navigationTitle;
@property (nonatomic, assign) CTWebDisplayType displayType;

@end

NS_ASSUME_NONNULL_END
