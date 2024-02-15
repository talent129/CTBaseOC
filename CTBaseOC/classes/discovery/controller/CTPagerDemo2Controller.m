//
//  CTPagerDemo2Controller.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/15.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTPagerDemo2Controller.h"
#import "JXPagerView.h"
#import "CTCategoryTitleView.h"
#import "CTSubPagerController.h"

#define TitlesViewHeight 50.0/375*SCREEN_Width
@interface CTPagerDemo2Controller ()<JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate, JXCategoryViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) CTCategoryTitleView *categoryView;
@property (nonatomic, strong) JXPagerView *pagerView;

@end

@implementation CTPagerDemo2Controller

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, CTScale(200))];
        _headerView.backgroundColor = [UIColor randomColor];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"JXPagerView使用";
    [self setupUI];
}

- (void)setupUI {
    [super setupUI];
    
    self.categoryView = [[CTCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, TitlesViewHeight)];
    self.categoryView.backgroundColor = [UIColor appColorWhite];
    self.categoryView.delegate = self;
    self.categoryView.titleLabelZoomEnabled = NO;
    self.categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
    self.categoryView.averageCellSpacingEnabled = NO;
    self.categoryView.cellWidthIncrement = CTScale(30);
    self.categoryView.cellSpacing = CTScale(10);
//    self.categoryView.collectionView.contentInset = UIEdgeInsetsMake(0, CTScale(5), 0, CTScale(5));
    
    self.pagerView = [[JXPagerView alloc] initWithDelegate:self];
    self.pagerView.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - kNavBarHeight);
    self.pagerView.mainTableView.gestureDelegate = self;
    [self.view addSubview:self.pagerView];
    
    self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    self.pagerView.mainTableView.backgroundColor = [UIColor clearColor];
    
    self.pagerView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.pagerView.mainTableView.mj_header beginRefreshing];
}

- (void)refresh {
    
    self.categoryView.titles = @[@"推荐", @"其他"];
    self.categoryView.defaultSelectedIndex = 0;
    
    [self.categoryView reloadData];
    [self.pagerView reloadData];
    [self.pagerView.mainTableView.mj_header endRefreshing];
}

#pragma mark - JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    NSUInteger height = self.headerView.height;
    return height;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return TitlesViewHeight;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return self.categoryView.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    CTSubPagerController *vc = [[CTSubPagerController alloc] init];
    return vc;
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXPagerMainTableViewGestureDelegate
- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end
