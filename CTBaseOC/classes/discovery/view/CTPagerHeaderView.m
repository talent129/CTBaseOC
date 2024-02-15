//
//  CTPagerHeaderView.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/15.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTPagerHeaderView.h"

@interface CTPagerHeaderView()

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UIView *desView;

@end

@implementation CTPagerHeaderView

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.text = @"This is header";
        _titleL.textColor = [UIColor randomColor];
        _titleL.font = [UIFont fontMedium16];
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}

- (UIView *)desView {
    if (!_desView) {
        _desView = [UIView new];
        _desView.backgroundColor = [UIColor randomColor];
    }
    return _desView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor randomColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.titleL];
    [self addSubview:self.desView];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.centerX.equalTo(@0);
    }];
    
    [self.desView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.titleL.mas_bottom).offset(10);
        make.width.mas_equalTo(CTScale(300));
        make.height.equalTo(@100).priorityHigh();
        make.bottom.mas_equalTo(-20);
    }];
    
    self.frame = CGRectMake(0, 0, SCREEN_Width, self.titleL.bottom + 130);
}

@end
