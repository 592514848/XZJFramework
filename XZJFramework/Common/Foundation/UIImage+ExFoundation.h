//
//  UIImage+ExFoundation.h
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/16.
//  Copyright © 2016 Youdar . All rights reserved.
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

-(UIImage*)adjustImageWithScaleToSize:(CGSize)size;
@end
