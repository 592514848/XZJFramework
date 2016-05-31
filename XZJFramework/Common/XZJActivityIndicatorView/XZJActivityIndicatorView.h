//
//  XZJActivityIndicatorView.h
//  Giivv
//
//  Created by Xiong, Zijun on 4/28/16.
//  Copyright © 2016 Youdar . All rights reserved.
//
#define ACTIVITYVIEW [XZJActivityIndicatorView shareManager]
#import <UIKit/UIKit.h>

@interface XZJActivityIndicatorView : UIView
/**
 设置颜色
 */
@property (readwrite, nonatomic) UIColor *bounceColor;
/**
 设置半径
 */
@property (readwrite, nonatomic) CGFloat radius;
/**
 设置动画延迟
 */
@property (readwrite, nonatomic) CGFloat delay;
/**
 设置动画持续时间
 */
@property (readwrite, nonatomic) CGFloat duration;

/**
 *  single class
 *
 *  @return activityView
 */
+ (XZJActivityIndicatorView *)shareManager;
/**
 *  start animating
 */
- (void)startAnimating;
/**
 *  start animating in parentView
 *
 *  @param parentiew parentView
 */
- (void)startAnimatingWithSuperView:(UIView *)parentiew;
/**
 *  stop animating
 */
- (void)stopAnimating;
@end
