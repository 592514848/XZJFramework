//
//  UIColor+AppConfigColor.h
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/16.
//  Copyright © 2016 Youdar . All rights reserved.
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
+(UIColor *)textLightBlackColor;

/**
 *  The default font gray
 *
 *  @return UIColor
 */
+(UIColor *)textGrayColor;

/**
 *  The default font blue
 *
 *  @return UIColor
 */
+(UIColor *)textBlueColor;

/**
 *  The default line gray color
 *
 *  @return UIColor
 */
+(UIColor *)lineGrayColor;

    
/**
 *  The default light gray color
 *
 *  @return UIColor
 */
+(UIColor *)textLightGrayColor;

/**
 *  theme color
 *
 *  @return UIColor
 */
+(UIColor *)themeColor;

/**
 *  The default line blue color
 *
 *  @return UIColor
 */
+(UIColor *)lineBlueColor;

/**
 *  The default red background
 *
 *  @return UIColor
 */
+(UIColor *)backgroundRedColor;

/**
 *  The default font red
 *
 *  @return UIColor
 */
+(UIColor *)textRedColor;

#pragma mark - The default font yeellow
+(UIColor *)textYellowColor;
@end
