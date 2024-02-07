//
//  CTNetService.m
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import "CTNetService.h"
#import "CTHTTPSessionManager.h"
#import "CTLoginController.h"
#import "CTNavigationController.h"
#import <YYModel/YYModel.h>

@implementation CTNetService

+ (void)requestType:(RequestType)type 
                url:(NSString *)url
             params:(id)params
            loading:(UIView *)loadingView
            success:(SuccessBlock)success
            failure:(FailureBlock)failure {
    if (loadingView) {
        [MBProgressHUD showLoadingWithView:loadingView];
    }
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status == NotReachable) {
        if (loadingView) {
            [MBProgressHUD dismissLoadingWithView:loadingView];
        }
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", [CTEnvTool sharedCTEnvTool].currentEnv? SERVER_HOST_Dev : SERVER_HOST_Pro, url];
    CTHTTPSessionManager *manager = [CTHTTPSessionManager manager];
    
    /// 接口请求头塞token
    if (![url isEqualToString:kLoginByPwd]) {
        NSString *token = [NSString stringWithFormat:@"Bearer %@", [CTUserManager getToken]];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }
    
    if (type == RequestTypeGet) {
        urlStr = [urlStr urlLinkEncode];
        [manager GET:urlStr parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (loadingView) {
                [MBProgressHUD dismissLoadingWithView:loadingView];
            }
            NSHTTPURLResponse *taskResponse = (NSHTTPURLResponse *)task.response;
            NSLog(@"\nget\nurl:%@\nresponseObject: \n%@", task.currentRequest.URL, responseObject);
            
            if ([responseObject[@"code"] intValue] == 401 || taskResponse.statusCode == 401) {
                // 处理登录失效
                [CTUserManager clearInfo];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"登录状态已失效" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"知道了" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    CTLoginController *login = [CTLoginController new];
                    CTNavigationController *loginNav = [[CTNavigationController alloc] initWithRootViewController:login];
                    [UIApplication sharedApplication].keyWindow.rootViewController = loginNav;
                    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
                }];
                [alert addAction:confirm];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            } else {
                if (success) {
                    success(responseObject);
                }
                if ([responseObject[@"code"] intValue] != 200 && loadingView) {
                    [CTToastUtil makeToastCenter:StrEmpty(responseObject[@"msg"])?@"失败":responseObject[@"msg"]];
                }
            }
            [manager.session finishTasksAndInvalidate];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (loadingView) {
                [MBProgressHUD dismissLoadingWithView:loadingView];
            }
            NSLog(@"+++++++++++get\nURL = %@\nparms = %@\nERROR = %@", task.currentRequest.URL, [params yy_modelToJSONString], error.localizedDescription);
            [CTToastUtil makeToastCenter:StrEmpty(error.localizedDescription)? @"接口异常!":error.code == -1003? @"当前网络不通畅，请检查您的网络设置":error.localizedDescription];
            if (failure) {
                failure(error);
            }
            [manager.session finishTasksAndInvalidate];
        }];
    } else {
        [manager POST:urlStr parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (loadingView) {
                [MBProgressHUD dismissLoadingWithView:loadingView];
            }
            NSLog(@"\npost\nurl:%@\nparams:%@\nresponseObject: \n%@", task.currentRequest.URL, [params yy_modelToJSONString], responseObject);
            NSHTTPURLResponse *taskResponse = (NSHTTPURLResponse *)task.response;
            if ([responseObject[@"code"] intValue] == 401 || taskResponse.statusCode == 401) {
                // 处理登录失效
                [CTUserManager clearInfo];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"登录状态已失效" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"知道了" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    CTLoginController *login = [CTLoginController new];
                    CTNavigationController *loginNav = [[CTNavigationController alloc] initWithRootViewController:login];
                    [UIApplication sharedApplication].keyWindow.rootViewController = loginNav;
                    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
                }];
                [alert addAction:confirm];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            } else {
                if (success) {
                    success(responseObject);
                }
                if ([responseObject[@"code"] integerValue] != 200 && loadingView) {
                    [CTToastUtil makeToastCenter:StrEmpty(responseObject[@"msg"])?@"失败":responseObject[@"msg"]];
                }
            }
            [manager.session finishTasksAndInvalidate];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (loadingView) {
                [MBProgressHUD dismissLoadingWithView:loadingView];
            }
            NSLog(@"+++++++++++post\nURL = %@\nparms = %@\nERROR = %@", task.currentRequest.URL, [params yy_modelToJSONString], error.localizedDescription);
            [CTToastUtil makeToastCenter:StrEmpty(error.localizedDescription)? @"接口异常!":error.code == -1003? @"当前网络不通畅，请检查您的网络设置":error.localizedDescription];
            if (failure) {
                failure(error);
            }
            [manager.session finishTasksAndInvalidate];
        }];
    }
}

+ (NSURLSessionDataTask *)post:(NSString *)url
                  withParamArr:(NSArray *)arr
                       success:(void (^)(id _Nonnull))success
                       failure:(void (^)(NSError * _Nonnull))failure {
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    request.timeoutInterval = 60.f;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 设置body
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil]];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"==result: %@", resultString);
            NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
            if (success) {
                success([responseObject yy_modelToJSONObject]);
            }
        } else {
            NSLog(@"error: %@", error);
            if (failure) {
                failure(error);
            }
        }
        [manager.session finishTasksAndInvalidate];
    }];
    [task resume];
    return task;
}

+ (NSURLSessionDataTask *)uploadImageWithUrl:(NSString *)url
                                  parameters:(NSDictionary *)parms
                   constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block
                                     success:(void (^)(id _Nullable))successblock
                                     failure:(void (^)(NSError * _Nullable))failBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //序列化
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    serializer.timeoutInterval = 60;
    
//    if (![url isEqualToString:kLogin] && !StrEmpty([ZJUserManager getUserInfo].toke)) {
//        [serializer setValue:[ZJUserManager getUserInfo].toke forHTTPHeaderField:@"token"];
//    }
    
    manager.requestSerializer = serializer;
    
    AFHTTPResponseSerializer *response = [AFHTTPResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    manager.responseSerializer = response;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/hr/%@", [[CTEnvTool sharedCTEnvTool] currentEnv]? SERVER_HOST_Dev : SERVER_HOST_Pro, url];
    
    return [manager POST:urlStr parameters:parms headers:nil constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (successblock) {
            successblock(response);
        }
        [manager.session finishTasksAndInvalidate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
        [manager.session finishTasksAndInvalidate];
    }];
}

+ (NSURLSessionDataTask *)postData:(NSString *)urlString
                            params:(id)params
                           success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                           failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", [[CTEnvTool sharedCTEnvTool] currentEnv]? SERVER_HOST_Dev : SERVER_HOST_Pro, urlString];
    CTHTTPSessionManager *manager = [CTHTTPSessionManager manager];
    NSURLSessionDataTask *dataTask = [manager POST:urlStr parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\npost\nresponseObject: \n%@\n%@", task.currentRequest.URL, responseObject);
        if (success) {
            success(task, responseObject);
        }
        [manager.session finishTasksAndInvalidate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\npost\nerror: \n%@\n%@", task.currentRequest.URL, error);
        if (failure) {
            failure(task, error);
        }
        [manager.session finishTasksAndInvalidate];
    }];
    return dataTask;
}

+ (NSURLSessionDataTask *)getData:(NSString *)urlString
                           params:(id)params
                          success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                          failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", [[CTEnvTool sharedCTEnvTool] currentEnv]? SERVER_HOST_Dev : SERVER_HOST_Pro, urlString];
    CTHTTPSessionManager *manager = [CTHTTPSessionManager manager];
    NSURLSessionDataTask *dataTask = [manager GET:urlStr parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\nget\nresponseObject: \n%@\n%@", task.currentRequest.URL, responseObject);
        if (success) {
            success(task, responseObject);
        }
        [manager.session finishTasksAndInvalidate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\nget\nerror: \n%@\n%@", task.currentRequest.URL, error);
        if (failure) {
            failure(task, error);
        }
        [manager.session finishTasksAndInvalidate];
    }];
    return dataTask;
}

+ (NSURLSessionDataTask *)upload:(NSString *)urlString
                          params:(id)params
       constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block
                         success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    CTHTTPSessionManager *manager = [CTHTTPSessionManager manager];
    NSURLSessionDataTask *dataTask = [manager POST:urlString parameters:params headers:nil constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\npost\nresponseObject: \n%@\n%@", task.currentRequest.URL, responseObject);
        if (success) {
            success(task, responseObject);
        }
        [manager.session finishTasksAndInvalidate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\npost\nerror: \n%@\n%@", task.currentRequest.URL, error);
        if (failure) {
            failure(task, error);
        }
        [manager.session finishTasksAndInvalidate];
    }];
    return dataTask;
}

+ (NSURLSessionDownloadTask *)download:(NSString *)urlString
                     completionHandler:(void (^)(NSURLResponse * _Nonnull, NSURL * _Nullable, NSError * _Nullable))handler {
    CTHTTPSessionManager *manager = [CTHTTPSessionManager manager];
    NSURLSessionDownloadTask *dataTask = [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[urlString urlLinkEncode]]] progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"targetPath: %@\n", targetPath);
        NSLog(@"fullPath: %@", fullPath);
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"download - filePath: %@", filePath);
        if (handler) {
            handler(response, filePath, error);
        }
        [manager.session finishTasksAndInvalidate];
    }];
    [dataTask resume];
    return dataTask;
}

@end
