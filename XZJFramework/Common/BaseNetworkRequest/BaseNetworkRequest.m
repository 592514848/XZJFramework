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
 *  request manager(AF_3.0 new method)
 */
@property(nonatomic, strong) AFHTTPSessionManager *networkingManager;

/**
 *  Authorization token
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
         *  The default timeout of 10s
         */
        self.timeoutInterval = 10.0f;
        /**
         *  initialization server token
         */
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.authToken = VALIDATE_STRING([userDefaults objectForKey: SERVER_TOKEN]);
    }
    return self;
}


#pragma mark - private method
#pragma mark Build request interface address
- (NSString *)requestUrlPath{
    return @"";
}

#pragma mark Build request parameters
- (NSDictionary *)parameters{
    return @{};
}

#pragma mark - public method
#pragma mark validate request parameters
- (BOOL)validateRequestParameters{
    /**
     *  The default is to verify through
     */
    return YES;
}

#pragma mark Return the data validation interfaces
- (BOOL)validateResponseData:(id) returnData{
    return YES;
}

#pragma mark The basic configuration information build request
- (BOOL)buildRequestConfigInfo{
    /**
     *  Verify the submitted data interface specification
     */
    if(![self validateRequestParameters]){
        return NO;
    }
    
    /**
     *  Set the custom timeout
     */
    [self.networkingManager.requestSerializer setTimeoutInterval: self.timeoutInterval];
    /**
     *  The type of setup to accept
     */
    [self.networkingManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil]];
    /**
     *  Set the authentication information
     */
    [self.networkingManager.requestSerializer setValue: self.authToken forHTTPHeaderField: @"Authorization"];
    return YES;
}

#pragma mark The Post method request data
- (void)postDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    /**
     *  The basic configuration information build request
     */
    if(![self buildRequestConfigInfo]){
        return;
    }
    
    /**
     *  Start a Post request data interface
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

#pragma mark The Get method request data
- (void)getDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    /**
     *  The basic configuration information build request
     */
    if(![self buildRequestConfigInfo]){
        return;
    }
    
    /**
     *  Began to Get request data interface
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
