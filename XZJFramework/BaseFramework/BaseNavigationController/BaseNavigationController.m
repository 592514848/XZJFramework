//
//  BaseNavigationController.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/7.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseTableViewController.h"
#import <CoreGraphics/CoreGraphics.h>

@interface BaseNavigationController()
/**
 *  屏幕截图数据源
 */
@property(nonatomic, strong)NSMutableArray *screenShotsList;

/**
 *  背景视图
 */
@property(nonatomic, strong)UIView *backgroundView;
/**
 *  蒙层
 */
@property(nonatomic, strong)UIView *maskView;
/**
 *  手势起始点
 */
@property(nonatomic, assign)CGPoint startTouchPoint;
/**
 *  是否在移动中
 */
@property(nonatomic, assign)BOOL isMoving;
/**
 *  显示上次截屏视图
 */
@property(nonatomic, strong)UIImageView *lastScreenShotView;
@end

@implementation BaseNavigationController
#pragma mark - getters and setters
- (NSMutableArray *)screenShotsList{
    if(!_screenShotsList){
        _screenShotsList = [NSMutableArray array];
    }
    return _screenShotsList;
}

- (UIView *)backgroundView{
    if(!_backgroundView){
        _backgroundView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
        [_backgroundView addSubview: self.maskView];
    }
    return _backgroundView;
}

- (UIView *)maskView{
    if(!_maskView){
        _maskView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
        [_maskView setBackgroundColor: [UIColor blackColor]];
    }
    return _maskView;
}

- (UIImageView *)lastScreenShotView{
    if(!_lastScreenShotView){
        _lastScreenShotView = [[UIImageView alloc] init];
    }
    return _lastScreenShotView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  添加侧滑手势
     */
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handleSwipeGesture:)];
    [self.view addGestureRecognizer: panGestureRecognizer];
}

#pragma mark -
#pragma mark Lateral spreads gestures
- (void)handleSwipeGesture:(UIGestureRecognizer *)sender
{
    if (self.viewControllers.count <= 1){
        return;
    }
    [self.view.superview insertSubview: self.backgroundView belowSubview: self.view];
    CGPoint translation=[sender locationInView: WINDOW];
    if(sender.state == UIGestureRecognizerStateBegan){
        self.startTouchPoint = translation;
        self.isMoving = YES;
        
        [self.backgroundView setHidden: NO];
        if (self.lastScreenShotView)
            [self.lastScreenShotView removeFromSuperview];
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        self.lastScreenShotView = [[UIImageView alloc] initWithImage: lastScreenShot];
        [self.backgroundView insertSubview: self.lastScreenShotView belowSubview: self.maskView];
    }
    else if(sender.state == UIGestureRecognizerStateEnded){
        self.isMoving = NO;
        [self.backgroundView setHidden: NO];
        if (translation.x - self.startTouchPoint.x > 50.0f) {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewToX: self.view.frame.size.width];
            } completion:^(BOOL finished) {
                if(finished){
                    [self popViewControllerAnimated: NO];
                    [self.view setLeft: 0.0f];
                    [self.backgroundView setHidden: YES];
                }
            }];
        }
        else{
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewToX: 0.0f];
            } completion:^(BOOL finished) {
                [self.backgroundView setHidden: YES];
            }];
        }
        return;
    }
    if (self.isMoving) {
        [self moveViewToX:translation.x - self.startTouchPoint.x];
    }
}

#pragma mark -
#pragma mark Move to the specified coordinates x
- (void)moveViewToX:(float) origin_x
{
    origin_x = origin_x > self.view.width ? self.view.height : origin_x;
    origin_x = origin_x < 0.0f ? 0.0f : origin_x;
    [self.view setLeft: origin_x];
    float scale = (origin_x / 6400) + 0.95;
    float alpha = 0.4 - (origin_x / 800);
    [self.lastScreenShotView setTransform: CGAffineTransformMakeScale(scale, scale)];
    [self.maskView setAlpha: alpha];
}

#pragma mark - The conversion of a UIView into a UIImage and realize the screenshots
- (UIImage *)viewRenderImage
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark -
#pragma mark UINavigationController Delegate
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIImage *shotImage = [self viewRenderImage];
    if(!IsNilOrNull(shotImage)){
        [self.screenShotsList addObject: shotImage];
    }
    if(self.viewControllers.count > 0){
        [UIView animateWithDuration: 0.3f animations:^{
            [self.tabBarController.tabBar setTop: SCREEN_HEIGHT];
        }];
    }
    else{
        if([viewController isKindOfClass: [BaseViewController class]]){
            [(BaseViewController *)viewController setContentHeight: SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT];
        }
    }
    [super pushViewController:viewController animated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.screenShotsList removeLastObject];
    if(self.viewControllers.count == 2){
        [UIView animateWithDuration: 0.3f animations:^{
            [self.tabBarController.tabBar setTop: SCREEN_HEIGHT - TABBAR_HEIGHT];
        }];
    }
    return [super popViewControllerAnimated: animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    [self.screenShotsList removeLastObject];
    [UIView animateWithDuration: 0.3f animations:^{
        [self.tabBarController.tabBar setTop: SCREEN_HEIGHT - TABBAR_HEIGHT];
    }];
    return [super popToRootViewControllerAnimated: animated];
};
@end
