//
//  BaseApplication.h
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/14.
//  Copyright © 2016 Youdar . All rights reserved.
//
#define BASEAPPLICATION [BaseApplication shareManager]
#define LOGINUSER_NAME [NSString stringWithFormat: @"%@ %@", [[BASEAPPLICATION loginUser] firstName],[[BASEAPPLICATION loginUser] lastName]]

#import <Foundation/Foundation.h>

@interface BaseApplication : NSObject
/**
 *  Whether the login
 */
@property(nonatomic, assign) BOOL isLogin;
/**
 *  The current logged in user
 */
//@property(nonatomic, strong) Donor *loginUser;

/**
 *  server's token
 */
@property(nonatomic, strong) NSString *serverToken;
/**
 *  current firstReaposer
 */
@property(nonatomic, strong) id currentFirstResponser;

/**
 *  static object
 *
 *  @return BaseApplication
 */
+ (BaseApplication *)shareManager;
/**
 *  Save the current logged in user
 *
 *  @param userInfo user model
 */
//- (void)saveLoginUser:(Donor *) userInfo;
/**
 *  Gets the current logged in user
 */
- (void)getLoginuser;
/**
 *  Log out
 */
- (void)removeLoginUser;
/**
 *  mark save token
 *
 *  @param token token
 */
- (void)saveToken:(NSString *) token;
/**
 *  remove token
 */
- (void)removeToken;
@end
