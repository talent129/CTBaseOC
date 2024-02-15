//
//  CTSubPagerController.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/15.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTBaseController.h"
#import "JXPagerView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SubPagerRefreshCompleteBlock)(void);

@interface CTSubPagerController : CTBaseController<JXPagerViewListViewDelegate>

@property (nonatomic, copy) SubPagerRefreshCompleteBlock refreshFinishedBlock;

@end

NS_ASSUME_NONNULL_END
