//
//  BaseApplication.m
//  Giivv
//
//  Created by 熊梓君 on 16/4/14.
//  Copyright © 2016年 Xiong, Zijun . All rights reserved.
//

#import "BaseApplication.h"

static BaseApplication *baseApplication = nil;
@implementation BaseApplication
#pragma mark - static object
+ (BaseApplication *)shareManager{
    @synchronized(self) {
        if(baseApplication == nil){
            baseApplication = [[BaseApplication alloc] init];
            /**
             *  登录状态初始化
             */
//            id userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile: USER_ARCHIVE];
//            if([userInfo isKindOfClass: [UserModel class]]){
//                baseApplication.loginUser = [NSKeyedUnarchiver unarchiveObjectWithFile: USER_ARCHIVE];
//                baseApplication.isLogin = (IsNilOrNull(baseApplication.loginUser) ? NO : YES);
//            }
        }
    }
    return baseApplication;
}

#pragma mark - public method
//#pragma mark 保存用户信息在本地
//- (void)saveLoginUser:(Donor *) userInfo{
//    [NSKeyedArchiver archiveRootObject: userInfo toFile: USER_ARCHIVE];
//    [baseApplication setLoginUser: [userInfo copy]];
//    [baseApplication setIsLogin: YES];
//}
//
//#pragma mark 获取本地保存的用户
//- (void)getLoginuser{
//    self.loginUser = [NSKeyedUnarchiver unarchiveObjectWithFile: USER_ARCHIVE];
//}

#pragma mark 注销
- (void)removeLoginUser{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath: USER_ARCHIVE]) {
        [defaultManager removeItemAtPath: USER_ARCHIVE error:nil];
    }
}
@end