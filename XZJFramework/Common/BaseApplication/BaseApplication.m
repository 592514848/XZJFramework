//
//  BaseApplication.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/14.
//  Copyright © 2016 Youdar . All rights reserved.
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
             *  login statusO
             */
//            id userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile: USER_ARCHIVE];
//            if([userInfo isKindOfClass: [Donor class]]){
//                baseApplication.loginUser = [NSKeyedUnarchiver unarchiveObjectWithFile: USER_ARCHIVE];
//                baseApplication.isLogin = (IsNilOrNull(baseApplication.loginUser) ? NO : YES);
//            }
            /**
             *  server's token
             */
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            baseApplication.serverToken = [userDefaults objectForKey: SERVER_TOKEN];
        }
    }
    return baseApplication;
}

#pragma mark - public method
#pragma mark Save the current logged in user
//- (void)saveLoginUser:(Donor *) userInfo{
//    [NSKeyedArchiver archiveRootObject: userInfo toFile: USER_ARCHIVE];
//    //local control touchID
//    BOOL isEnableTouchID = [[baseApplication loginUser] isEnableTouchID];
//    [baseApplication setLoginUser: [userInfo copy]];
//    [baseApplication.loginUser setIsEnableTouchID: isEnableTouchID];
//    [baseApplication setIsLogin: YES];
//}

#pragma mark Gets the current logged in user
- (void)getLoginuser{
//    self.loginUser = [NSKeyedUnarchiver unarchiveObjectWithFile: USER_ARCHIVE];
}

#pragma mark log out
- (void)removeLoginUser{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath: USER_ARCHIVE]) {
        [defaultManager removeItemAtPath: USER_ARCHIVE error:nil];
    }
    [self removeToken];
}

#pragma mark save token
- (void)saveToken:(NSString *) token{
//    if(IsNilOrNull(token)){
//        return;
//    }
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setValue: token forKey: SERVER_TOKEN];
//    [userDefaults synchronize];
//    self.serverToken = token;
}

#pragma mark remove token
- (void)removeToken{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults removeObjectForKey: SERVER_TOKEN];
//    [userDefaults synchronize];
//    self.serverToken = nil;
}
@end