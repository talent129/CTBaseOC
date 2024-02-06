//
//  UITableView+clear.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/5.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UITableView+clear.h"

@implementation UITableView (clear)

- (void)clearRestCell {
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

@end
