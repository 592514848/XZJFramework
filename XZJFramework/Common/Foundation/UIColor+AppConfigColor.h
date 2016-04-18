//
//  UIColor+AppConfigColor.h
//  Giivv
//
//  Created by 熊梓君 on 16/4/16.
//  Copyright © 2016年 Xiong, Zijun . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AppConfigColor)
/**
 *  background color
 *
 *  @return UIColor
 */
+(UIColor *)viewBackgroundColor;

/**
 *  App default black color
 *
 *  @return UIColor
 */
+(UIColor *)textBlackColor;

/**
 *  The default font gray
 *
 *  @return UIColor
 */
+(UIColor *)textGrayColor;
@end
