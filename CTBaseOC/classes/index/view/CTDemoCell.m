//
//  CTDemoCell.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/7.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTDemoCell.h"
#import "CTDemoModel.h"

@interface CTDemoCell ()

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *contentL;
@property (nonatomic, strong) UILabel *timeL;
@property (nonatomic, strong) UILabel *lineV;

@end

@implementation CTDemoCell

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.textColor = [UIColor randomColor];
        _titleL.font = [UIFont fontMedium16];
        _titleL.numberOfLines = 0;
    }
    return _titleL;
}

- (UILabel *)contentL {
    if (!_contentL) {
        _contentL = [[UILabel alloc] init];
        _contentL.textColor = [UIColor randomColor];
        _contentL.font = [UIFont font14];
        _contentL.numberOfLines = 0;
    }
    return _contentL;
}

- (UILabel *)timeL {
    if (!_timeL) {
        _timeL = [[UILabel alloc] init];
        _timeL.textColor = [UIColor randomColor];
        _timeL.font = [UIFont font12];
        _timeL.numberOfLines = 0;
        _timeL.textAlignment = NSTextAlignmentRight;
    }
    return _timeL;
}

- (UILabel *)lineV {
    if (!_lineV) {
        _lineV = [UIView new];
        _lineV.backgroundColor = [UIColor lineColor];
    }
    return _lineV;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor appColorWhite];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.contentL];
    [self.contentView addSubview:self.timeL];
    [self.contentView addSubview:self.lineV];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.top.equalTo(@16);
        make.trailing.mas_equalTo(-16);
    }];
    
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@16);
        make.trailing.mas_equalTo(-16);
        make.top.equalTo(self.titleL.mas_bottom).offset(10);
    }];
    
    [self.timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-16);
        make.top.equalTo(self.contentL.mas_bottom).offset(10);
    }];
    
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeL.mas_bottom).offset(10);
        make.leading.equalTo(@16);
        make.trailing.mas_equalTo(-16);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)setModel:(CTDemoModel *)model {
    _model = model;
    
    self.titleL.text = model.title;
    self.contentL.text = model.content;
    self.timeL.text = model.time;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
