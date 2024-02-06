//
//  CTHTTPSessionManager.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTHTTPSessionManager.h"

@implementation CTHTTPSessionManager

+ (instancetype)manager {
    return [[self alloc] initWithBaseURL:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        return [self initWithBaseURL:nil];
    }
    return self;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        [self setupHttpHeader];
        [self setupResponse];
    }
    return self;
}

// 设置一些请求头信息
- (void)setupHttpHeader {
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.requestSerializer.timeoutInterval = kTimeOut;
//    [self.requestSerializer setValue:@"1" forHTTPHeaderField:@"sysType"]; // 系统类型 1.iOS / 2.Android
//    [self.requestSerializer setValue:kAppVersion forHTTPHeaderField:@"code"]; // 版本号
}

// 设置响应信息
- (void)setupResponse {
//    AFHTTPResponseSerializer *response = [AFHTTPResponseSerializer serializer];
//    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/json", @"text/javascript", @"text/html", @"application/octet-stream", nil];
//    self.responseSerializer = response;
    
    // AFJSONResponseSerializer JSON解析器 默认的解析器
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/json", @"text/javascript", @"text/html", @"application/octet-stream", @"application/pdf", nil];
}

@end
