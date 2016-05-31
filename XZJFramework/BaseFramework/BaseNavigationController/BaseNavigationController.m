//
//  BaseNavigationController.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/7.
//  Copyright © 2016 Youdar. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseTableViewController.h"
#import <CoreGraphics/CoreGraphics.h>

@interface BaseNavigationController() <UINavigationControllerDelegate>
/**
 *  screen snapshot array
 */
@property(nonatomic, strong)NSMutableArray *screenShotsList;

/**
 *  background view
 */
@property(nonatomic, strong)UIView *backgroundView;
/**
 *  black mask view
 */
@property(nonatomic, strong)UIView *maskView;
/**
 *  start point
 */
@property(nonatomic, assign)CGPoint startTouchPoint;
/**
 *  Whether on the move
 */
@property(nonatomic, assign)BOOL isMoving;
/**
 *  The last screenshot
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
//        /**
//         *  Tips: Here don't backgroundView added to the window, otherwise backgroundView has been suspended in the self.view
//         */
//        [self.view.superview insertSubview: self.backgroundView belowSubview: self.view];
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
    [self setDelegate: self];
    /**
     * disable default gesture
     */
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    /**
     *  add customer gesture
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
    /**
     *  Tips: Here don't backgroundView added to the window, otherwise backgroundView has been suspended in the self.view
     */
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
            /**
             *  If the end of the coordinates is greater than the start moving coordinate 50 pixels is animation effects
             */
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewToX: self.view.frame.size.width];
            } completion:^(BOOL finished) {
                if(finished){
                    /**
                     *  The return on a layer and reduction points
                     */
                    [self popViewControllerAnimated: NO];
                    [self.view setLeft: 0.0f];
                    [self.backgroundView setHidden: YES];
                }
            }];
        }
        else{
            /**
             *  No more than 50 when they move in place
             */
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
    /**
     *  zooming value
     */
    float scale = (origin_x / 6400) + 0.95;
    /**
     *  alpha value
     */
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
    /**
     *  Image array deposit in a current interface image, and then push
     */
//    if(self.viewControllers.count == 1){
//        //when vc is root viewController
//        if([viewController isKindOfClass: [BaseViewController class]]){
//            [[(BaseViewController *)viewController view] setHeight: SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT];
//            if([viewController isKindOfClass: [BaseTableViewController class]]){
//                [[(BaseTableViewController *)viewController mainTableView] setHeight: viewController.view.height];
//            }
//        }
//    }
    UIImage *shotImage = [self viewRenderImage];
    if(!IsNilOrNull(shotImage)){
        [self.screenShotsList addObject: shotImage];
    }
    /**
     *  From the root view push on to the next hid tabBar viewcontroller
     */
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
    /**
     *  Remove the last interface image
     */
    [self.screenShotsList removeLastObject];
    return [super popViewControllerAnimated: animated];
}

#pragma mark - navigation delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    /**
     *  When back to the root view shows the tabbar
     */
    if(self.viewControllers.count == 1){
        /**
         *  show tabBar
         */
        [UIView animateWithDuration: 0.3f animations:^{
            [self.tabBarController.tabBar setTop: SCREEN_HEIGHT - TABBAR_HEIGHT];
        }];
    }
}

#pragma mark - public methods
- (UIImageView *)navigationBarLine:(UIView *)view{
    //return
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    //Recursive search
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self navigationBarLine:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
@end
