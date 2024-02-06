//
//  CTBaseController.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTBaseController.h"

@interface CTBaseController ()

@property (nonatomic, assign) BOOL refreshing;

@end

@implementation CTBaseController

#pragma mark -
- (MJRefreshNormalHeader *)ct_header {
    if (!_ct_header) {
        _ct_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onRefresh)];
    }
    return _ct_header;
}

- (MJRefreshBackNormalFooter *)ct_footer {
    if (!_ct_footer) {
        _ct_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onLoadMore)];
    }
    return _ct_footer;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor backgroundColor];
    [self configData];
}

- (void)configData {
    self.pageNum = 1;
}

// UI
- (void)setupUI {
    
}

// 请求
- (void)request {
    
}

@end
