//
//  CTMineController.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTMineController.h"

@interface CTMineController ()

@end

@implementation CTMineController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的";
    self.view.backgroundColor = [UIColor randomColor];
    [self setupUI];
}

- (void)setupUI {
    [super setupUI];
}

@end
