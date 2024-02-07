//
//  CTNetService.h
//  CTBaseOCFrameOne
//
//  Created by Curtis on 2024/2/1.
//  Copyright © 2024 CT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>
#import "CTInterfaceDefine.h"
#import <Reachability/Reachability.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet,
    RequestTypePost
};

typedef void(^SuccessBlock)(id _Nullable result);
typedef void(^FailureBlock)(NSError * _Nullable error);

@interface CTNetService : NSObject

+ (void)requestType:(RequestType)type
                url:(NSString *)url
             params:(id _Nullable)params
            loading:(UIView * _Nullable)loadingView
            success:(SuccessBlock)success
            failure:(FailureBlock)failure;

+ (NSURLSessionDataTask *)post:(NSString *)url
                  withParamArr:(NSArray *)arr
                       success:(void (^)(id _Nonnull))success
                       failure:(void (^)(NSError * _Nonnull))failure;

+ (NSURLSessionDataTask *)uploadImageWithUrl:(NSString *)url
                                  parameters:(NSDictionary * __nullable)parms
                   constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData>formData))block
                                     success:(void(^)(id _Nullable response))successblock
                                     failure:(void(^)(NSError * _Nullable))failBlock;

+ (NSURLSessionDataTask *)postData:(NSString *)urlString
                            params:(nullable id)params
                           success:(nullable void(^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                           failure:(nullable void(^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

+ (NSURLSessionDataTask *)getData:(NSString *)urlString
                           params:(nullable id)params
                          success:(nullable void(^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                          failure:(nullable void(^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

+ (NSURLSessionDataTask *)upload:(NSString *)urlString
                          params:(nullable id)params
       constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                         success:(nullable void(^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                         failure:(nullable void(^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

+ (NSURLSessionDownloadTask *)download:(NSString *)urlString
                     completionHandler:(void(^)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error))handler;

@end

NS_ASSUME_NONNULL_END
