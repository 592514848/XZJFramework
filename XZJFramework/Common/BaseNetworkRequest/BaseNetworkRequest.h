//
//  BaseNetworkRequest.h
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/10.
//  Copyright © 2016 Youdar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestSuccessBlock)(id DAO, id data);
typedef void (^RequestFailedBlock)(id DAO, NSError *error);

@interface BaseNetworkRequest : NSObject
/**
 *  Network request timeout
 */
@property(nonatomic, assign) CGFloat timeoutInterval;

@property(nonatomic, assign) BOOL showActivityIndicator;
/**
 *  request data
 */
@property(nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

/**
 *  Build request interface address
 *
 *  @return The requested interface address
 */
- (NSString *)requestUrlPath;

/**
 *  validate request parameters
 */
- (BOOL)validateRequestParameters;

/**
 *  Build request parameters
 *
 *  @return The parameters of the request
 */
- (NSDictionary *)parameters;

/**
 *  Return the data validation interfaces
 *
 *  @param returnData Interface the data returned
 *
 *  @return Validation by returning YES;Validation failure returns NO
 */
- (BOOL)validateResponseData:(id) returnData;

/**
 *  The Get method request data
 */
- (void)getDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure;

/**
 *  The Post method request data
 */
- (void)postDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure;

/**
 *  The Put method request data
 */
- (void)putDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure;

/**
 *  The Delete method request data
 */
- (void)deleteDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure;

- (void)uploadData: (NSData *)imageData externName:(NSString *) externName  success: (RequestSuccessBlock)success failure:(RequestFailedBlock)failure;
@end
