//
//  UIColor+SNFoundation.h
//  SNFoundation
//
//  Created by 熊梓君 on 16/4/10.
//  Copyright (c) 2014年 Xiong, ZIjun. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Color to create
 */
#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#undef  RGBACOLOR
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#undef	HEX_RGB
#define HEX_RGB(V)		[UIColor colorWithRGBHex:V]

@interface UIColor (SNFoundation)

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
