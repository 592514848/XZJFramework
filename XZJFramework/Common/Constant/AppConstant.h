//
//  AppConstant.h
//  Giivv
//
//  Created by 熊梓君 on 16/4/4.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
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
 *  window object
 */
#define WINDOW [[UIApplication sharedApplication] keyWindow]
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
#define VALIDATE_STRING(str) IsNilOrNull(str) ? @"" : str

/**
 *  validate nsnumber
 */
#define VALIDATE_NUMBER(number) IsNilOrNull(number) ? @0 : number

/**
 *  validate NSArray
 */
#define VALIDATE_Array(arr) IsNilOrNull(arr) ? [NSArray array] : arr

/**
 *  Image Url transfer
 */
#define IMAGE_URL(str) [NSURL URLWithString: str]

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
///////////////////////Begin: App Parameters Macro definition///////////////////////
////////////////////////////////////////////////////////////////////////////////////

#endif /* AppConstant_h */
