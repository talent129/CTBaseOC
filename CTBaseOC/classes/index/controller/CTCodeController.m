//
//  CTCodeController.m
//  CTBaseOC
//
//  Created by Curtis on 2024/2/21.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTCodeController.h"
#import "CTDemoModel.h"

@interface CTCodeController ()

@end

@implementation CTCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self request];
}

- (void)request {
    [super request];
    
    NSString *key = @"test.coder";
    
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dicT = @{@"title": @"标题1", @"content": @"内容1", @"time":@"时间1"};
    CTDemoModel *model = [CTDemoModel yy_modelWithDictionary:dicT];
    [arr addObject:model];
    
    /**
     前提是model实现了NSCoding协议
     // 序列化数据 NSCoding
     - (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
     // 反序列化数据 NSCoding
     - (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
     */
    [CTTool setCustomObject:arr forKey:key];
    
    NSMutableArray *resArr = [CTTool getCustomObjectForKey:key];
    NSLog(@"==> %@ == %d", resArr, [resArr isKindOfClass:[NSMutableArray class]]);
    if ([resArr isKindOfClass:[NSMutableArray class]]) {
        NSLog(@"可变数组");
    }
    
    NSLog(@"*************************");
    
    NSString *key1 = @"test.coder1";
    /**
     前提是model实现了NSCoding协议
     // 序列化数据 NSCoding
     - (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
     // 反序列化数据 NSCoding
     - (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
     */
    [CTTool setCustomObject:[NSArray arrayWithArray:arr] forKey:key1];
    
    NSArray *resArr1 = [CTTool getCustomObjectForKey:key1];
    NSLog(@"==> %@ == %d", resArr1, [resArr1 isKindOfClass:[NSMutableArray class]]);
    if (![resArr1 isKindOfClass:[NSMutableArray class]]) {
        NSLog(@"不可变数组");
    }
}

- (void)setupUI {
    [super setupUI];
    
}

@end
