//
//  CTUserModel.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTUserModel : CTBaseModel

@property (nonatomic, copy) NSString *cc_id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *headPhoto;

@end

NS_ASSUME_NONNULL_END
