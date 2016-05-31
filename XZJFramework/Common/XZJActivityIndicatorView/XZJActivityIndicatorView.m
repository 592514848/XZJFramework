//
//  XZJActivityIndicatorView.m
//  Giivv
//
//  Created by Xiong, Zijun on 4/28/16.
//  Copyright © 2016 Youdar . All rights reserved.
//

#import "XZJActivityIndicatorView.h"

@interface XZJActivityIndicatorView ()
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) BOOL isAddCircleView;
@property (nonatomic, strong) UILabel *loadingLabel;
@end

@implementation XZJActivityIndicatorView
#pragma amrk - calss method
static XZJActivityIndicatorView *activityView = nil;
+ (XZJActivityIndicatorView *)shareManager{
    @synchronized (self) {
        if(activityView == nil){
            activityView = [[XZJActivityIndicatorView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
            [activityView setCenter: CGPointMake(SCREEN_WIDTH / 2.0f, SCREEN_HEIGHT / 2.0f)];
            [activityView.layer setCornerRadius: 5.0f];
            [activityView setBackgroundColor: [[UIColor alloc] initWithWhite: 0.1f alpha: 0.6f]];
            [activityView setAlpha: 0.0f];
        }
    }
    return activityView;
}

#pragma mark - getters and setters
- (UILabel *)loadingLabel{
    if(!_loadingLabel){
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 20.0f)];
        [_loadingLabel setText: @" Loading..."];
        [_loadingLabel setTextAlignment: NSTextAlignmentCenter];
        [_loadingLabel setTextColor: [UIColor whiteColor]];
        [_loadingLabel setAlpha: 0.0f];
        [_loadingLabel setFont: [UIFont systemFontOfSize: 12.0f]];
//        [_loadingLabel setCenter: CGPointMake(self.width/ 2.0f, self.height/2.0f + self.radius + 10.0f)];
        [_loadingLabel setCenter: CGPointMake(self.width/ 2.0f, self.height/2.0f + self.radius)];
    }
    return _loadingLabel;
}

#pragma mark - Initializations
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

#pragma mark - private method
- (void)defaultSetting
{
    self.bounceColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    self.radius = 20.0f;
    self.delay = 1.0f;
    self.duration = 1.0f;
}

- (UIView *)createCircleWithRadius:(CGFloat)radius color:(UIColor *)color
{
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.radius*2, self.radius*2)];
    circle.backgroundColor = self.bounceColor;
    circle.layer.cornerRadius = self.radius;
    circle.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.5f);
    return circle;
}

- (CABasicAnimation *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.fromValue = [NSNumber numberWithFloat:0.0f];
    anim.toValue = [NSNumber numberWithFloat:1.0f];
    anim.autoreverses = YES;
    anim.duration = duration;
    anim.beginTime = CACurrentMediaTime()+delay;
    anim.removedOnCompletion = NO;
    anim.repeatCount = INFINITY;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return anim;
}

- (void)drawCircles
{
    if(!self.isAddCircleView){
        for (NSInteger i = 0; i < 2; i++) {
            UIView *circle = [self createCircleWithRadius:self.radius color:self.bounceColor];
            [circle setTransform:CGAffineTransformMakeScale(0, 0)];
            [circle.layer addAnimation:[self createAnimationWithDuration:self.duration delay:(self.delay*i)] forKey:@"scale"];
            [self addSubview:circle];
        }
        [self setIsAddCircleView: YES];
    }
}

- (void)removeCircles
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

#pragma mark - public method
- (void)startAnimating
{
    [[[UIApplication sharedApplication] keyWindow] addSubview: activityView];
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront: activityView];
    if (!self.isAnimating) {
        self.isAnimating = YES;
        [self addSubview: self.loadingLabel];
        //animate load background
        __weak typeof(self) weakSelf = self;
//        self.hidden = NO;
        [UIView animateWithDuration: 0.3f animations:^{
            weakSelf.alpha = 1.0f;
            weakSelf.transform = CGAffineTransformMakeScale(1, 1);
            weakSelf.loadingLabel.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [weakSelf drawCircles];
            //animate load loading label
//            [UIView animateWithDuration: 1.0f animations:^{
//               weakSelf.loadingLabel.alpha = 1.0f;
//            }];
        }];
    }
}

- (void)startAnimatingWithSuperView:(UIView *)parentiew
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [parentiew addSubview: activityView];
        [parentiew bringSubviewToFront: activityView];
        if (!self.isAnimating) {
            self.isAnimating = YES;
            [self addSubview: self.loadingLabel];
            //animate load background
            __weak typeof(self) weakSelf = self;
            self.hidden = NO;
            [UIView animateWithDuration: 0.3f animations:^{
                weakSelf.alpha = 1.0f;
                weakSelf.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                [weakSelf drawCircles];
                //animate load loading label
                [UIView animateWithDuration: 1.0f animations:^{
                    weakSelf.loadingLabel.alpha = 1.0f;
                }];
            }];
        }
    });
}
- (void)stopAnimating
{
    if(self.isAnimating){
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.isAnimating = NO;
            
            [UIView animateWithDuration: 0.5f animations:^{
                weakSelf.alpha = 0.0f;
                weakSelf.loadingLabel.alpha = 0.0f;
            } completion:^(BOOL finished) {
//                weakSelf.hidden = YES;
            }];
        });
    }
}



- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
}
@end
