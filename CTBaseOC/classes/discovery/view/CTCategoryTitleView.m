//
//  CTCategoryTitleView.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/15.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTCategoryTitleView.h"
#import "CTCategoryCell.h"

@implementation CTCategoryTitleView

//返回自定义的cell class
- (Class)preferredCellClass {
    return [CTCategoryCell class];
}

@end
