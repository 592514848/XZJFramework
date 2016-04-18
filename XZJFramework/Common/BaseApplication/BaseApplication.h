//
//  BaseApplication.h
//  Giivv
//
//  Created by 熊梓君 on 16/4/14.
//  Copyright © 2016年 Xiong, Zijun . All rights reserved.
//
#define BASEAPPLICATION [BaseApplication shareManager]
#import <Foundation/Foundation.h>

@interface BaseApplication : NSObject
/**
 *  是否登录
 */
@property(nonatomic, assign) BOOL isLogin;
/**
 *  当前登录用户
 */
//@property(nonatomic, strong) UserModel *loginUser;

/**
 *  单例
 *
 *  @return BaseApplication
 */
+ (BaseApplication *)shareManager;

/**
 *  保存用户信息在本地
 *
 *  @param 用户信息
 */
//- (void)saveLoginUser:(UserModel *) userInfo;
/**
 *  获取本地保存的用户
 */
//- (void)getLoginuser;
/**
 *  注销
 */
- (void)removeLoginUser;
@end
