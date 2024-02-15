//
//  CTPagerDemoController.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/7.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTPagerDemoController.h"
#import "JXPagerView.h"
#import "JXCategoryTitleView.h"
#import "CTSubPagerController.h"
#import "JXCategoryIndicatorImageView.h"
#import "CTPagerHeaderView.h"
#import "CTPagerDemo2Controller.h"

#define CategoryHeight 60
@interface CTPagerDemoController ()<JXCategoryViewDelegate, JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>

@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) CTPagerHeaderView *headerView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;

@end

@implementation CTPagerDemoController

- (CTPagerHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[CTPagerHeaderView alloc] init];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"JXPagerView使用";
    [self addNavigationTitleItem:@"JXPager使用" tintColor:[UIColor appColorWhite] withLeft:NO withTarget:self withAction:@selector(pagerClick)];
    [self setupUI];
}

- (void)setupUI {
    [super setupUI];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, CategoryHeight)];
    self.categoryView.titles = @[@"推荐", @"问答", @"动态", @"比较长title1", @"比较长title2", @"比较长title3"];
    self.categoryView.backgroundColor = [UIColor backgroundColor];
    self.categoryView.delegate = self;
    self.categoryView.titleLabelZoomEnabled = NO; // 禁止缩放 默认NO
    self.categoryView.averageCellSpacingEnabled = NO; // 是否均分 默认YES
    self.categoryView.cellWidthIncrement = 30; // 宽度补偿 默认0
    self.categoryView.cellSpacing = 5; // cell之间的间距，默认20
    self.categoryView.titleSelectedColor = [UIColor textColor];
    self.categoryView.titleSelectedFont = [UIFont fontMedium14];
    self.categoryView.titleColor = [UIColor secondaryColor];
    self.categoryView.titleFont = [UIFont font14];
    
    JXCategoryIndicatorImageView *indicatorImage = [[JXCategoryIndicatorImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 8)];
    indicatorImage.indicatorImageView.image = [UIImage imageNamed:@"indicator"];
    indicatorImage.indicatorImageViewSize = CGSizeMake(24, 8);
    indicatorImage.verticalMargin = 8;
    self.categoryView.indicators = @[indicatorImage];
    
    self.pagerView = [[JXPagerView alloc] initWithDelegate:self];
    self.pagerView.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - kNavBarHeight);
    self.pagerView.backgroundColor = [UIColor backgroundColor];
    self.pagerView.mainTableView.gestureDelegate = self;
    [self.view addSubview:self.pagerView];
    
    self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    self.pagerView.mainTableView.backgroundColor = [UIColor backgroundColor];
    
    self.pagerView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onRefresh)];
}

#pragma mark -JXPagerViewDelegate
- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    NSUInteger height = self.headerView.height;
    return height;
}

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerView;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return CategoryHeight;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    // 和categoryView的item数量一致
    return self.categoryView.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    CTSubPagerController *vc = [CTSubPagerController new];
    WEAKSELF
    [vc setRefreshFinishedBlock:^{
        [weakSelf.pagerView.mainTableView.mj_header endRefreshing];
    }];
    return vc;
}

- (void)onRefresh {
    [self request];
    [self.pagerView reloadData];
}

#pragma mark -JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark -JXPagerMainTableViewGestureDelegate
- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

- (void)pagerClick {
    CTPagerDemo2Controller *vc = [CTPagerDemo2Controller new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
