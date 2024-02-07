//
//  CTDiscoveryController.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTDiscoveryController.h"

@interface CTDiscoveryController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation CTDiscoveryController

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor orangeColor];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor backgroundColor];
    }
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发现";
    self.view.backgroundColor = [UIColor appColorWhite];
    [self setupUI];
}

- (void)setupUI {
    [super setupUI];
    
    UILabel *pageTitleL = [UILabel new];
    pageTitleL.text = @"UIScrollView自适应高度写法";
    pageTitleL.textColor = [UIColor textColor];
    pageTitleL.font = [UIFont font14];
    [self.view addSubview:pageTitleL];
    [pageTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.centerX.equalTo(@0);
    }];
    
    /**
     1. scrollView添加到视图上
     2. contentView添加到scrollView上
     3. 设置contentView的约束 如下
     make.edges.equalTo(self.scrollView);
     make.width.equalTo(self.scrollView);
     4. 其他元素Y方向上约束好
     5. 最下面的元素bottom约束
     */
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.top.equalTo(pageTitleL.mas_bottom).offset(20);
        make.bottom.equalTo(@0);
    }];
    
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    UILabel *titleL = [UILabel new];
    titleL.text = @"唐多令·芦叶满汀洲";
    titleL.textColor = [UIColor textColor];
    titleL.font = [UIFont fontMedium16];
    titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.centerX.equalTo(self.contentView);
    }];
    
    UILabel *authorL = [UILabel new];
    authorL.text = @"宋·刘过";
    authorL.textColor = [UIColor descColor];
    authorL.font = [UIFont font12];
    authorL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:authorL];
    [authorL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleL.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView);
    }];
    
    UILabel *poemL = [UILabel new];
    poemL.text = @"安远楼小集，侑觞歌板之姬黄其姓者，乞词于龙洲道人，为赋此《唐多令》。同柳阜之、刘去非、石民瞻、周嘉仲、陈孟参、孟容。时八月五日也。\n芦叶满汀洲，寒沙带浅流。二十年重过南楼。柳下系船犹未稳，能几日，又中秋。\n黄鹤断矶头，故人今在否？旧江山浑是新愁。欲买桂花同载酒，终不似，少年游。";
    poemL.textColor = [UIColor secondaryColor];
    poemL.font = [UIFont font14];
    poemL.textAlignment = NSTextAlignmentLeft;
    poemL.numberOfLines = 0;
    [self.contentView addSubview:poemL];
    [poemL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(authorL.mas_bottom).offset(10);
        make.leading.equalTo(@20);
        make.trailing.mas_equalTo(-20);
    }];
    
    UIView *spaceView = [UIView new];
    spaceView.backgroundColor = [UIColor randomColor];
    [self.contentView addSubview:spaceView];
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(poemL.mas_bottom).offset(10);
        make.centerX.equalTo(@0);
        make.width.mas_equalTo(SCREEN_Width - 40);
        make.height.mas_equalTo(800);
    }];
    
    UILabel *endL = [UILabel new];
    endL.text = @"ending";
    endL.textColor = [UIColor textColor];
    endL.font = [UIFont font12];
    endL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:endL];
    [endL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spaceView.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView);
        make.bottom.mas_equalTo(-10);
    }];
}

@end
