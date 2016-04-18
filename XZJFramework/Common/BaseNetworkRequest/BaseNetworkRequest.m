//
//  BaseNetworkRequest.m
//  Giivv
//
//  Created by 熊梓君 on 16/4/10.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//
#define REQUEST_BASEURL @"http://editor.swagger.io"
#import "BaseNetworkRequest.h"
#import <AFNetworking.h>

@interface BaseNetworkRequest()
/**
 *  请求管理器
 */
@property(nonatomic, strong) AFHTTPSessionManager *networkingManager;

/**
 *  接口认证token
 */
@property(nonatomic, strong) NSString *authToken;
@end

@implementation BaseNetworkRequest
#pragma mark getters and setters
- (AFHTTPSessionManager *)networkingManager{
    if(!_networkingManager){
        _networkingManager = [[AFHTTPSessionManager alloc] initWithBaseURL: [NSURL URLWithString: REQUEST_BASEURL]];
    }
    return _networkingManager;
}

#pragma mark - init
- (id)init{
    self = [super init];
    if(self){
        /**
         *  默认超时时间
         */
        self.timeoutInterval = 10.0f;
        /**
         *  默认接口认证token
         */
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.authToken = VALIDATE_STRING([userDefaults objectForKey: SERVER_TOKEN]);
    }
    return self;
}


#pragma mark - public method
#pragma mark 构建请求地址
- (NSString *)requestUrlPath{
    return @"";
}

#pragma mark 构建请求参数
- (NSDictionary *)parameters{
    return @{};
}

#pragma mark 验证请求参数
- (BOOL)validateRequestParameters{
    return YES;
}

#pragma mark 验证接口返回数据
- (BOOL)validateResponseData:(id) returnData{
    return YES;
}

#pragma mark 请求的基本配置信息
- (BOOL)buildRequestConfigInfo{
    /**
     *  验证请求参数
     */
    if(![self validateRequestParameters]){
        return NO;
    }
    
    /**
     *  设置请求超时时间
     */
    [self.networkingManager.requestSerializer setTimeoutInterval: self.timeoutInterval];
    /**
     *  设置请求的的接受类型
     */
    [self.networkingManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil]];
    /**
     *  设置认证token
     */
    [self.networkingManager.requestSerializer setValue: self.authToken forHTTPHeaderField: @"Authorization"];
    return YES;
}

#pragma mark Post
- (void)postDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    if(![self buildRequestConfigInfo]){
        return;
    }
    
    /**
     *  开始Post 请求
     */
    WS(weakSelf);
    [self.networkingManager POST: [self requestUrlPath] parameters: [self parameters] progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self validateResponseData: responseObject]) {
            if (success) success(weakSelf.networkingManager, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(IsNilOrNull(failure)){
            return;
        }
        failure(weakSelf.networkingManager, error);
    }];
}

#pragma mark Get
- (void)getDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    if(![self buildRequestConfigInfo]){
        return;
    }
    
    /**
     *  开始Get请求
     */
    WS(weakSelf);
    [self.networkingManager GET: [self requestUrlPath] parameters: [self parameters] progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self validateResponseData: responseObject]) {
            if (success) success(weakSelf.networkingManager, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(IsNilOrNull(failure)){
            return;
        }
        failure(weakSelf.networkingManager, error);
    }];
}
@end
