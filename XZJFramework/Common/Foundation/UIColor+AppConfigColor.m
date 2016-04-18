//
//  UIColor+AppConfigColor.m
//  Giivv
//
//  Created by 熊梓君 on 16/4/16.
//  Copyright © 2016年 Xiong, Zijun . All rights reserved.
//

#import "UIColor+AppConfigColor.h"

@implementation UIColor (AppConfigColor)

#pragma mark - 默认背景颜色
+(UIColor *)viewBackgroundColor{
    return HEX_RGB(0xf0f0f0);
}

#pragma mark - 默认黑色字体颜色
+(UIColor *)textBlackColor{
    return HEX_RGB(0x343434);
}

#pragma mark - 默认灰色字体颜色
+(UIColor *)textGrayColor{
    return HEX_RGB(0xa9a9a9);
}
@end
