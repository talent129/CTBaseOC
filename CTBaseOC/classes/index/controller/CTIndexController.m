//
//  CTIndexController.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTIndexController.h"
#import "CTDemoModel.h"
#import "CTDemoCell.h"
#import "CTIndexBannerView.h"

@interface CTIndexController ()<UITableViewDelegate, UITableViewDataSource, CTIndexBannerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, strong) CTIndexBannerView *bannerView;

@end

@implementation CTIndexController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor backgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = self.ct_header;
        _tableView.mj_footer = self.ct_footer;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
        _tableView.tableHeaderView = self.bannerView;
    }
    return _tableView;
}

- (CTIndexBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[CTIndexBannerView alloc] init];
        _bannerView.bannerDelegate = self;
    }
    return _bannerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    
    self.isFirst = YES;
    [self setupUI];
    [self request];
}

- (void)request {
    [super request];
    
    NSArray *dataList = @[@{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"}, @{@"title":@"春望",@"content":@"国破山河在，城春草木深。感时花溅泪，恨别鸟惊心。火连三月，家书抵万金。头搔更短，浑欲不胜簪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"}, @{@"title":@"春望",@"content":@"国破山河在，城春草木深。感时花溅泪，恨别鸟惊心。火连三月，家书抵万金。头搔更短，浑欲不胜簪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"},@{@"title":@"春望",@"content":@"国破山河在，城春草木深。感时花溅泪，恨别鸟惊心。火连三月，家书抵万金。头搔更短，浑欲不胜簪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"},@{@"title":@"春望",@"content":@"国破山河在，城春草木深。感时花溅泪，恨别鸟惊心。火连三月，家书抵万金。头搔更短，浑欲不胜簪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"},@{@"title":@"春望",@"content":@"国破山河在，城春草木深。感时花溅泪，恨别鸟惊心。火连三月，家书抵万金。头搔更短，浑欲不胜簪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"},@{@"title":@"春望",@"content":@"国破山河在，城春草木深。感时花溅泪，恨别鸟惊心。火连三月，家书抵万金。头搔更短，浑欲不胜簪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"},@{@"title":@"春望",@"content":@"国破山河在，城春草木深。感时花溅泪，恨别鸟惊心。火连三月，家书抵万金。头搔更短，浑欲不胜簪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"},@{@"title":@"春望",@"content":@"国破山河在，城春草木深。感时花溅泪，恨别鸟惊心。火连三月，家书抵万金。头搔更短，浑欲不胜簪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"},@{@"title":@"春望",@"content":@"国破山河在，城春草木深。感时花溅泪，恨别鸟惊心。火连三月，家书抵万金。头搔更短，浑欲不胜簪。",@"time":@"2024-02-07"}, @{@"title":@"将进酒",@"content":@"君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。",@"time":@"2024-02-07"}];
    
    for (NSDictionary *dicT in dataList) {
        CTDemoModel *model = [CTDemoModel yy_modelWithDictionary:dicT];
        [self.dataArray addObject:model];
    }
    
    // banner
    self.bannerView.bannerList = @[@"https://t7.baidu.com/it/u=1076097100,3808793036&fm=193&f=GIF", @"https://t7.baidu.com/it/u=3013393994,903593432&fm=193&f=GIF", @"https://t7.baidu.com/it/u=2587978747,4268841661&fm=193&f=GIF"];
    
    [self.tableView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endRefresh];
    });
    
    /*
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNum"] = [NSString stringWithFormat:@"%ld", self.pageNum];
    params[@"pageSize"] = [NSString stringWithFormat:@"%d", kPageSize];
    [CTNetService requestType:(RequestTypeGet) url:kDemo params:params loading:self.isFirst? self.view : nil success:^(id  _Nullable result) {
        if ([result[@"code"] intValue] == 200) {
            self.isFirst = NO;
            if (self.pageNum == 1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *rows = result[@"rows"];
            for (NSDictionary *dicT in rows) {
                CTDemoModel *model = [CTDemoModel yy_modelWithDictionary:dicT];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            
            if (rows.count < kPageSize) {
                [self endRefreshNoMoreData];
            } else {
                [self endRefresh];
            }
        } else {
            [CTToastUtil makeToastCenter:result[@"msg"] withView:self.view];
            [self.tableView reloadData];
            [self endRefresh];
        }
    } failure:^(NSError * _Nullable error) {
        [self.tableView reloadData];
        [self endRefresh];
    }];
     */
}

- (void)setupUI {
    [super setupUI];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTDemoCell *cell = [tableView dequeueReusableCellWithIdentifier:[CTDemoCell cellIdentifier]];
    if (!cell) {
        cell = [[CTDemoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CTDemoCell cellIdentifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath: %@", indexPath);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark -CTIndexBannerViewDelegate
- (void)didSelectItemAtIndex:(NSUInteger)idx {
    NSLog(@"===> %ld", idx);
}

@end
