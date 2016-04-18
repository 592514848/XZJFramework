//
//  UIImage+ExFoundation.h
//  Giivv
//
//  Created by 熊梓君 on 16/4/16.
//  Copyright © 2016年 Xiong, Zijun . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ExFoundation)

/**
 *  The compressed images under 12M
 *
 *  @param image Will be compressed images
 *
 *  @return compressed image data
 */
- (NSData *)compressedImgLess12M:(UIImage*)image;
@end
