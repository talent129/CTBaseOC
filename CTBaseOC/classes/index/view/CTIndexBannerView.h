//
//  CTIndexBannerView.h
//  CTBaseOC
//
//  Created by Curtis on 2024/2/14.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CTIndexBannerViewDelegate <NSObject>

- (void)didSelectItemAtIndex:(NSUInteger)idx;

@end

@interface CTIndexBannerView : UIView

@property (nonatomic, weak) id<CTIndexBannerViewDelegate> bannerDelegate;
@property (nonatomic, strong) NSArray *bannerList;

@end

NS_ASSUME_NONNULL_END
