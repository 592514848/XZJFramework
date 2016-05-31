//
//  AppConstant.h
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/4.
//  Copyright © 2016 Youdar. All rights reserved.
//

#ifndef AppConstant_h
#define AppConstant_h

////////////////////////////////////////////////////////////////////////////////////
///////////////////////////Begin: Device Macro definition///////////////////////////
/**
 *  device width and height
 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define HEIGHT_PROPORTION SCREEN_HEIGHT / 568.0f
#define WIDTH_PROPORTION 375.0f / SCREEN_WIDTH
/**
 *  tabbar height
 */
#define TABBAR_HEIGHT 49.0f

/**
 *  navitaionbar height
 */
#define NAVIGATIONBAR_HEIGHT 64.0f

/**
 *  statusbar height
 */
#define STATUSBAR_HEIGHT 20.0f

/**
 *  UIApplication object
 */
#define UIAPPLICATION [UIApplication sharedApplication]

/**
 *  window object
 */
#define WINDOW [[UIApplication sharedApplication] keyWindow]

/**
 *  device system version
 */
#define DEVICE_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
///////////////////////////End: Device Macro definition///////////////////////////
//////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
///////////////////////////Begin: Function Macro definition/////////////////////////
/**
 *  __weak self define
 */
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/**
 *  object is not nil and null
 */
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))

/**
 *  object is nil or null
 */
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

/**
 *  string is nil or null or empty
 */
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

/**
 *  Array is nil or null or empty
 */
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

/**
 *  validate string
 */
#define VALIDATE_STRING(str) (IsNilOrNull(str) ? @"" : str)

/**
 *  update string
 */
#define UPDATE_STRING(old, new) ((IsNilOrNull(new) || IsStrEmpty(new)) ? old : new)

/**
 *  validate NSNumber
 */
#define VALIDATE_NUMBER(number) (IsNilOrNull(number) ? @0 : number)

/**
 *  update NSNumber
 */
#define UPDATE_NUMBER(old, new) (IsNilOrNull(new) ? old : new)

/**
 *  validate NSArray
 */
#define VALIDATE_ARRAY(arr) (IsNilOrNull(arr) ? [NSArray array] : arr)

/**
 *  update NSArray
 */
#define UPDATE_ARRAY(old, new) (IsNilOrNull(new) ? old : new)

/**
 *  update NSDate
 */
#define UPDATE_DATE(old, new) (IsNilOrNull(new) ? old : new)

/**
 *  validate bool
 */
#define VALIDATE_BOOL(value) ((value > 0) ? YES : NO)

/**
 *  Image Url transfer
 */
#define IMAGE_URL(str) [NSURL URLWithString: str]

/**
 *  nil turn to null
 */
#define Nil_TURNTO_Null(objc) (objc == nil ? [NSNull null] : objc)
///////////////////////////End: Function Macro definition/////////////////////////
//////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////
///////////////////////Begin: App Parameters Macro definition///////////////////////
/**
 *  The path of the local user information
 */
#define USER_ARCHIVE [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent: @"user.archiver"]

/**
 *  Server token
 */
#define SERVER_TOKEN @"ServerToken"

/**
 *  default Image
 */
#define DEFAULT_IMAGE [UIImage imageNamed: @"common_default"]

/**
 *  defaults pageSize
 */
#define DEFAULT_PAGESIZE 30
///////////////////////Begin: App Parameters Macro definition///////////////////////
////////////////////////////////////////////////////////////////////////////////////

#endif /* AppConstant_h */
