//
//  UIColor+AppConfigColor.m
//  Giivv
//
//  Created by 熊梓君 on 16/4/16.
//  Copyright © 2016年 Xiong, ZIjun . All rights reserved.
//

#import "UIColor+AppConfigColor.h"

@implementation UIColor (AppConfigColor)

#pragma mark - The default view background
+(UIColor *)viewBackgroundColor{
    return HEX_RGB(0xf0f0f0);
}

#pragma mark - The default font black
+(UIColor *)textBlackColor{
    return HEX_RGB(0x343434);
}

#pragma mark - The default font gray
+(UIColor *)textGrayColor{
    return HEX_RGB(0xa9a9a9);
}
@end
