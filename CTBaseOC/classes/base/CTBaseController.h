//
//  CTBaseController.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/DZNEmptyDataSet-umbrella.h>
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

// 无数据页面代理
@interface CTBaseController : UIViewController<DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

// 页码
@property (nonatomic, assign) NSInteger pageNum;
// 数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
// 下拉刷新header
@property (nonatomic, strong) MJRefreshNormalHeader *ct_header;
// 上拉加载footer
@property (nonatomic, strong) MJRefreshBackNormalFooter *ct_footer;

// UI
- (void)setupUI;

// 请求
- (void)request;

// 下拉刷新方法
- (void)onRefresh;

// 上拉加载更多
- (void)onLoadMore;

// 结束刷新
- (void)endRefresh;

- (void)endRefreshNoMoreData;

// pop
- (void)backBtnClick;

/// 透明导航栏
- (void)configTranslucentNavbar;

/// 透明导航栏 /底色
- (void)configTranslucentNavbarWithBackgroundColor:(UIColor *)backgroundColor;

/// light 样式的title /back buton
- (void)configLightStyleNavbar;

/// dark 样式的title /back buton
- (void)configDarkStyleNavbar;

// 先reloadData 后endRefreshing

@end

NS_ASSUME_NONNULL_END
