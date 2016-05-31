//
//  UIImage+ExFoundation.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/16.
//  Copyright © 2016 Youdar . All rights reserved.
//

#import "UIImage+ExFoundation.h"

@implementation UIImage (ExFoundation)

#pragma mark - The compressed images under 12M
- (NSData *)compressedImgLess12M:(UIImage*)image{
    NSData *imageData = UIImageJPEGRepresentation(image,1);
    int i = 1;
    while ([imageData length]>12000000 && i < 100)
    {
        imageData = UIImageJPEGRepresentation(image,(double)(100-i)/100.0f);
        i++;
    }
    return imageData;
}

#pragma mark adjust iamge size
-(UIImage*)adjustImageWithScaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
