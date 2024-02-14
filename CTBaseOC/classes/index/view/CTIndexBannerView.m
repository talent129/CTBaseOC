//
//  CTIndexBannerView.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/14.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTIndexBannerView.h"
#import "SDCycleScrollView.h"

@interface CTIndexBannerView()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation CTIndexBannerView

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(ceilf(CTScale(15)), CTScale(16), ceilf((SCREEN_Width - CTScale(30))), ceilf(120/345.0*(SCREEN_Width - CTScale(30)))) delegate:self placeholderImage:[UIImage createImageWithColor:[UIColor backgroundColor] size:CGSizeMake(ceilf(SCREEN_Width - CTScale(30)), ceilf(120/345.0*(SCREEN_Width - CTScale(30))))]];
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.backgroundColor = [UIColor appColorWhite];
        _cycleScrollView.layer.cornerRadius = CTScale(12);
        _cycleScrollView.layer.masksToBounds = true;
        _cycleScrollView.currentPageDotColor = [UIColor themeColor];
        _cycleScrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:0.5];
//        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"cycle_current"];
//        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"cycle_normal"];
        _cycleScrollView.autoScrollTimeInterval = 5;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        
        _cycleScrollView.pageControlBottomOffset = CTScale(5);
    }
    return _cycleScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_Width, ceilf(120/345.0*(SCREEN_Width - CTScale(30))) + CTScale(32));
        self.backgroundColor = [UIColor randomColor];
        [self addSubview:self.cycleScrollView];
    }
    return self;
}

- (void)setBannerList:(NSArray *)bannerList {
    _bannerList = bannerList;
    
    _cycleScrollView.imageURLStringsGroup = bannerList;
}

#pragma mark -SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if ([self.bannerDelegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [self.bannerDelegate didSelectItemAtIndex:index];
    }
}

@end
