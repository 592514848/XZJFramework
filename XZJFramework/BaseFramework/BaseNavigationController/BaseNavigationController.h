//
//  BaseNavigationController.h
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/7.
//  Copyright © 2016 Youdar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController
@property(nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
- (UIImageView *)navigationBarLine:(UIView *)view;
@end
