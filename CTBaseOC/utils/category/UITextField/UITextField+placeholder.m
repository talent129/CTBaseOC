//
//  UITextField+placeholder.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/5.
//  Copyright © 2024 CT. All rights reserved.
//

#import "UITextField+placeholder.h"

@implementation UITextField (placeholder)

- (void)modifyPlaceholder:(UIColor *)color
                     font:(UIFont *)font {
    if (StrEmpty(self.placeholder)) {
        return;
    }
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
    [placeholderString addAttribute:NSForegroundColorAttributeName
                        value:color
                        range:NSMakeRange(0, self.placeholder.length)];
    [placeholderString addAttribute:NSFontAttributeName
                        value:font
                        range:NSMakeRange(0, self.placeholder.length)];
    self.attributedPlaceholder = placeholderString;
}

@end
