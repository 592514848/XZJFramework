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
 *  网络请求超时时间
 */
@property(nonatomic, assign) CGFloat timeoutInterval;


/**
 *  构建请求地址
 *
 *  @return 请求地址
 */
- (NSString *)requestUrlPath;

/**
 *  验证请求参数
 */
- (BOOL)validateRequestParameters;

/**
 *  构建请求参数
 *
 *  @return 请求参数
 */
- (NSDictionary *)parameters;

/**
 *  验证接口返回数据
 *
 *  @param 接口返回数据
 *
 *  @return 验证结果（YES:验证成功 ； NO:验证失败）
 */
- (BOOL)validateResponseData:(id) returnData;

/**
 *  Get 请求方式
 */
- (void)getDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure;

/**
 *  Post 请求方式
 */
- (void)postDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure;
@end
