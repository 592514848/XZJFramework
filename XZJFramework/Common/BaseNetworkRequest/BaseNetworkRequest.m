//
//  BaseNetworkRequest.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/10.
//  Copyright © 2016 Youdar. All rights reserved.
//
#define REQUEST_BASEURL @"http://ec1.youdar.net:4221"
#define REQUEST_APIPATH [NSString stringWithFormat: @"/rest/v1%@", [self requestUrlPath]]

#import "BaseNetworkRequest.h"
#import <AFNetworking.h>

@interface BaseNetworkRequest()
/**
 *  request manager(AF_3.0 new method)
 */
@property(nonatomic, strong) AFHTTPSessionManager *networkingManager;
/**
 *  Response error code
 */
@property(nonatomic, strong) NSDictionary *responseErrorCodeDictionary;
@end

@implementation BaseNetworkRequest
#pragma mark getters and setters
- (AFHTTPSessionManager *)networkingManager{
    if(!_networkingManager){
        _networkingManager = [[AFHTTPSessionManager alloc] initWithBaseURL: [NSURL URLWithString: REQUEST_BASEURL]];
    }
    return _networkingManager;
}

- (NSDictionary *)responseErrorCodeDictionary{
    if(!_responseErrorCodeDictionary){
//        _responseErrorCodeDictionary = @{@101: @"Illegal arguments", @102: @"resource not found", @999: @"internal error", @901: @"JWT Token is expired", @902: @"JWT Token cannot be resolved or auth failed", @110: @"request for an email sending too frequently", @111: @"Token from email is invalid"};
        _responseErrorCodeDictionary = @{};
    }
    return _responseErrorCodeDictionary;
}

#pragma mark - init
- (id)init{
    self = [super init];
    if(self){
        /**
         *  The default timeout of 10s
         */
        self.timeoutInterval = 10.0f;
        self.showActivityIndicator = YES;
    }
    return self;
}


#pragma mark - private method
//- (void)cancelOperation
//{
//    NSArray *operations = self.networkingManager.operationQueue.operations;
//    for (NSOperationQueue *httpOperation in operations) {
////        NSString *oldRequestURLStr = httpOperation.request.URL.absoluteString;
////        if ([oldRequestURLStr isEqualToString:[self fullURLPath]]) {
//            [httpOperation can];
////        }
//    }
//}

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
    /**
     *  100: call api success
     *  201: need register(sign up)
     */
    NSNumber *codeKey = [NSNumber numberWithInteger: [[returnData objectForKey: @"code"] integerValue]];
    if([codeKey integerValue] != 100 && [codeKey integerValue] != 201 && [codeKey integerValue] != 208){
        if([[self.responseErrorCodeDictionary allKeys] containsObject: codeKey]){
            [TOASTVIEW showWithText: [self.responseErrorCodeDictionary objectForKey: codeKey]];
        }
        else if(!IsStrEmpty([returnData objectForKey: @"msg"])){
            [TOASTVIEW showWithText: [returnData objectForKey: @"msg"]];
        }
        else{
            [TOASTVIEW showWithText: @"API error"];
        }
        return NO;
    }
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
     *  loading view
     */
    if(self.showActivityIndicator){
        [ACTIVITYVIEW stopAnimating];
        [ACTIVITYVIEW startAnimating];
    }
    [EMPTYDATAVIEW dismiss];
    
    /**
     *  Set the custom timeout
     */
    [self.networkingManager.requestSerializer setTimeoutInterval: self.timeoutInterval];
    
    /**
     *  The type of setup to accept
     */
    [self.networkingManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects: @"application/json", nil]];
    
    /**
     *  Set request type
     */
    self.networkingManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    /**
     *  Set respons type
     */
    self.networkingManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    /**
     *  Set header information
     */
    [self.networkingManager.requestSerializer setValue: @"application/json" forHTTPHeaderField: @"Accept"];
    [self.networkingManager.requestSerializer setValue: @"application/json" forHTTPHeaderField: @"Content-Type"];

    /**
     *  Set the authentication information
     */
    if(!IsStrEmpty([[BaseApplication shareManager] serverToken])){
        [self.networkingManager.requestSerializer setValue: [[BaseApplication shareManager] serverToken] forHTTPHeaderField: @"Authorization"];
    }
    return YES;
}

#pragma mark The Post method request data
- (void)postDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    /**
     *  The basic configuration information build request
     */
    if(![self buildRequestConfigInfo]){
//        if(IsNilOrNull(failure)){
//            return;
//        }
//        failure(self.networkingManager, nil);
        return;
    }
    /**
     *  Start a Post request data interface
     */
    NSLog(@"parameters = %@", [self parameters]);
    NSLog(@"REQUEST_APIPATH = %@", REQUEST_APIPATH);
    WS(weakSelf);
    self.sessionDataTask = [self.networkingManager POST: REQUEST_APIPATH parameters: [self parameters] progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self validateResponseData: responseObject]) {
            if(IsNilOrNull(success)){
                return;
            }
            success(weakSelf.networkingManager, responseObject);
        }
        else{
            failure(weakSelf.networkingManager, nil);
        }
        /**
         *  dismiss loading view
         */
        if(self.showActivityIndicator){
            [ACTIVITYVIEW stopAnimating];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //dismiss loading view
        [ACTIVITYVIEW stopAnimating];
        [TOASTVIEW showWithText: @"API error"];
        //failure block
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
    NSLog(@"parameters = %@", [self parameters]);
    self.sessionDataTask = [self.networkingManager GET: REQUEST_APIPATH parameters: [self parameters] progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self validateResponseData: responseObject]) {
            if(IsNilOrNull(success)){
                return;
            }
            success(weakSelf.networkingManager, responseObject);
        }
        /**
         *  dismiss loading view
         */
        if(self.showActivityIndicator){
            [ACTIVITYVIEW stopAnimating];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //dismiss loading view
        [ACTIVITYVIEW stopAnimating];
        //failure block
        if(IsNilOrNull(failure)){
            return;
        }
        failure(weakSelf.networkingManager, error);
    }];
}

#pragma mark The Put method request data
- (void)putDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    /**
     *  The basic configuration information build request
     */
    if(![self buildRequestConfigInfo]){
        return;
    }
    
    /**
     *  Start a Put request data interface
     */
    NSLog(@"parameters = %@", [self parameters]);
    WS(weakSelf);
    self.sessionDataTask = [self.networkingManager PUT: REQUEST_APIPATH parameters:[self parameters] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self validateResponseData: responseObject]) {
            if(IsNilOrNull(success)){
                return;
            }
            success(weakSelf.networkingManager, responseObject);
        }
        /**
         *  dismiss loading view
         */
        if(self.showActivityIndicator){
            [ACTIVITYVIEW stopAnimating];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //dismiss loading view
        [ACTIVITYVIEW stopAnimating];
        //failure block
        if(IsNilOrNull(failure)){
            return;
        }
        failure(weakSelf.networkingManager, error);
    }];
}

#pragma mark The Delete method request data
- (void)deleteDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    /**
     *  The basic configuration information build request
     */
    if(![self buildRequestConfigInfo]){
        return;
    }
    /**
     *  Start a Delete request data interface
     */
    NSLog(@"REQUEST_APIPATH = %@, parameters = %@", REQUEST_APIPATH, [self parameters]);
    WS(weakSelf);
    /**
     *  In order to put parameters in the request body when using "DELETE" method,
     *  "DELETE" method must be removed from the "HTTPMethodsEncodingParametersInURI"
     */
    [self.networkingManager.requestSerializer setHTTPMethodsEncodingParametersInURI: [NSSet setWithObjects:@"GET", @"HEAD", nil]];
    self.sessionDataTask = [self.networkingManager DELETE: REQUEST_APIPATH parameters:[self parameters] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(IsNilOrNull(success)){
            return;
        }
        success(weakSelf.networkingManager, responseObject);
        /**
         *  dismiss loading view
         */
        if(self.showActivityIndicator){
            [ACTIVITYVIEW stopAnimating];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //dismiss loading view
        [ACTIVITYVIEW stopAnimating];
        //failure block
        if(IsNilOrNull(failure)){
            return;
        }
        failure(weakSelf.networkingManager, error);
    }];
}

#pragma mark The upload data
- (void)uploadData: (NSData *)imageData externName:(NSString *) externName  success: (RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    /**
     *  The basic configuration information build request
     */
    //Verify the submitted data interface specification
    if(![self validateRequestParameters]){
        return;
    }
    //loading view
    [ACTIVITYVIEW startAnimating];
    [EMPTYDATAVIEW dismiss];
    
    //Set the custom timeout
    [self.networkingManager.requestSerializer setTimeoutInterval: self.timeoutInterval];
    
    //The type of setup to accept
    [self.networkingManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects: @"application/json", nil]];
    
    //Set request type, Set respons type
    self.networkingManager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.networkingManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //Set header information
    [self.networkingManager.requestSerializer setValue: @"Multipart/form-data" forHTTPHeaderField: @"Content-Type"];
    
    //Set the authentication information
    if(!IsStrEmpty([[BaseApplication shareManager] serverToken])){
        [self.networkingManager.requestSerializer setValue: [[BaseApplication shareManager] serverToken] forHTTPHeaderField: @"Authorization"];
    }

    /**
     *  Start a Post request data interface
     */
    NSLog(@"parameters = %@", [self parameters]);
    NSLog(@"REQUEST_APIPATH = %@", REQUEST_APIPATH);
    WS(weakSelf);
    
    self.sessionDataTask = [self.networkingManager POST: REQUEST_APIPATH parameters:[self parameters] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData: imageData name: @"file" fileName: [@"file" randomFileName: externName] mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self validateResponseData: responseObject]) {
            if(IsNilOrNull(success)){
                return;
            }
            success(weakSelf.networkingManager, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //dismiss loading view
        [ACTIVITYVIEW stopAnimating];
        [TOASTVIEW showWithText: @"API error"];
        //failure block
        if(IsNilOrNull(failure)){
            return;
        }
        failure(weakSelf.networkingManager, error);
    }];
}

- (void)dealloc{
    if(!IsNilOrNull(self.sessionDataTask)){
        [self.sessionDataTask cancel];
    }
}
@end
