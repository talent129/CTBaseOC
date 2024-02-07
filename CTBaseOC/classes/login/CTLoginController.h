//
//  CTLoginController.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTBaseController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CTLoginDisplayType) {
    CTLoginDisplayTypePush,
    CTLoginDisplayTypePresent
};

@interface CTLoginController : CTBaseController

@property (nonatomic, assign) CTLoginDisplayType displayType;

@end

NS_ASSUME_NONNULL_END
