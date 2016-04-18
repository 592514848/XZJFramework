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
 *  默认系统背景颜色
 *
 *  @return UIColor
 */
+(UIColor *)viewBackgroundColor;

/**
 *  默认黑色字体颜色
 *
 *  @return UIColor
 */
+(UIColor *)textBlackColor;

/**
 *  默认灰色字体颜色
 *
 *  @return UIColor
 */
+(UIColor *)textGrayColor;
@end
