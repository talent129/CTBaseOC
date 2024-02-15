//
//  CTTabBarController.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTTabBarController.h"
#import "CTBaseController.h"
#import "CTNavigationController.h"

@interface CTTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation CTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    self.tabBar.translucent = NO;
    
    [self configControllers];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self addShapeLayer];
}

/// tabbar 阴影
- (void)addShapeLayer {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = [UIBezierPath bezierPathWithRoundedRect:self.tabBar.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(0, 0)].CGPath;
    layer.fillColor = [UIColor appColorWhite].CGColor;
    layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.tabBar.bounds cornerRadius:15].CGPath;
    layer.shadowColor = [UIColor colorWithHexString:@"#999999" alpha:0.2].CGColor;
    layer.shadowOpacity = 1;
    layer.shadowRadius = 6;
    layer.shadowOffset = CGSizeMake(0, -1);
    layer.cornerRadius = 15;
    
    layer.shouldRasterize = true;
    layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    if (self.shapeLayer) {
        [self.tabBar.layer replaceSublayer:self.shapeLayer with:layer];
    } else {
        [self.tabBar.layer insertSublayer:layer atIndex:0];
    }
    self.shapeLayer = layer;
}

- (void)configControllers {
    NSArray *controllers = [self setUpControllers:@[@"CTIndexController", @"CTDiscoveryController", @"CTMineController"]];
    self.viewControllers = controllers;
    
    NSArray *titles = @[@"首页", @"发现", @"我的"];
    NSArray *icons = @[@"index", @"discovery", @"mine"];
    
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.title = titles[idx];
        
        NSString *normal = [NSString stringWithFormat:@"tab_%@_normal", icons[idx]];
        NSString *selected = [NSString stringWithFormat:@"tab_%@_selected", icons[idx]];
        [self configItemWithItem:obj Normal:normal selected:selected];
    }];
}

- (NSArray *)setUpControllers:(NSArray *)controllers {
    NSMutableArray *list = [NSMutableArray array];
    for (NSString *controllerStr in controllers) {
        CTBaseController *vc = [[NSClassFromString(controllerStr) alloc] init];
        CTNavigationController *nav = [[CTNavigationController alloc] initWithRootViewController:vc];
        [list addObject:nav];
    }
    return list;
}

- (void)configItemWithItem:(UITabBarItem *)item Normal:(NSString *)normal selected:(NSString *)selected {
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [UITabBarAppearance new];

        [appearance setBackgroundImage:[UIImage createImageWithColor:[UIColor appColorWhite]]];
        [appearance setShadowImage:[UIImage createImageWithColor:[UIColor appColorWhite]]];
        
        UIOffset offset = UIOffsetMake(0, -2);
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = offset;
        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = offset;

        // 设置未被选中的颜色
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSFontAttributeName: [UIFont tabBarItemFont], NSForegroundColorAttributeName: [UIColor appColorBlack]};
        // 设置被选中时的颜色
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{NSFontAttributeName: [UIFont tabBarItemSelectedFont], NSForegroundColorAttributeName: [UIColor themeColor]};
        self.tabBar.standardAppearance = appearance;
    } else {
        // tabBar背景
        [self.tabBar setBackgroundImage:[UIImage createImageWithColor:[UIColor appColorWhite]]];
        //去掉tabBar顶部黑线
        [self.tabBar setShadowImage:[UIImage new]];
        
        /*
         typedef struct UIOffset {
         CGFloat horizontal, vertical; // specify amount to offset a position, positive for right or down, negative for left or up
         } UIOffset;
         */
        
        UIOffset offset = UIOffsetMake(0, -2); //正: 向右或向下 负: 向左或向上
        [item setTitlePositionAdjustment:offset];
        
        [item setTitleTextAttributes:@{NSFontAttributeName: [UIFont tabBarItemFont], NSForegroundColorAttributeName: [UIColor appColorBlack]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName: [UIFont tabBarItemSelectedFont], NSForegroundColorAttributeName: [UIColor themeColor]} forState:UIControlStateSelected];
    }
    
    UIImage *normalImg = [[UIImage imageNamed:normal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item setImage:normalImg];
    UIImage *selectImg = [[UIImage imageNamed:selected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item setSelectedImage:selectImg];
}

#pragma mark -UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    NSLog(@"tabBarController:shouldSelectViewController: %@", viewController);
    return YES;
}

#pragma mark -UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    NSLog(@"tabBar:didSelectItem: %@", item);
}

@end
