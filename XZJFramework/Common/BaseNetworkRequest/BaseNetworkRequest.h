//
//  BaseNetworkRequest.h
//  Giivv
//
//  Created by 熊梓君 on 16/4/10.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestSuccessBlock)(id DAO, id data);
typedef void (^RequestFailedBlock)(id DAO, NSError *error);

@interface BaseNetworkRequest : NSObject
/**
 *  Network request timeout
 */
@property(nonatomic, assign) CGFloat timeoutInterval;


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
@end
