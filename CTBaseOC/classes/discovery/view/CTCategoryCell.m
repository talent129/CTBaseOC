//
//  CTCategoryCell.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/15.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTCategoryCell.h"

@interface CTCategoryCell()

@property (nonatomic, strong) UILabel *titleL;

@end

@implementation CTCategoryCell

- (void)initializeViews {
    [super initializeViews];
    
    self.titleL = [UILabel labelWithFont:[UIFont fontMedium12] textColor:[UIColor textColor] alignment:NSTextAlignmentCenter];
    [self.titleL setCornerRadius:CTScale(15)];
    [self.contentView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CTScale(30));
        make.leading.trailing.centerY.equalTo(self.contentView);
    }];
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    
    JXCategoryTitleCellModel *model = (JXCategoryTitleCellModel *)cellModel;
    self.titleL.text = model.title;
    if (cellModel.selected) {
        self.titleL.backgroundColor = [UIColor themeColor];
        self.titleL.textColor = [UIColor appColorWhite];
    } else {
        self.titleL.backgroundColor = [UIColor backgroundColor];
        self.titleL.textColor = [UIColor textColor];
    }
    [self.titleL sizeToFit];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
