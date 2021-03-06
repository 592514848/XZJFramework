//
//  ToastView.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/9.
//  Copyright © 2016 Youdar. All rights reserved.
//

#import "ToastView.h"
static ToastView * toastView = nil;

@interface ToastView()
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UIAlertView *alertView;
@end

@implementation ToastView
#pragma mark - calss method
+(ToastView *)shareManager{
    @synchronized(self) {
        if(toastView == nil){
            toastView = [[ToastView alloc] init];
        }
    }
    return toastView;
}

#pragma mark - getters and setters
- (UILabel *)textLabel{
    if(!_textLabel){
        _textLabel = [[UILabel alloc] init];
        [_textLabel setBackgroundColor: [UIColor clearColor]];
        [_textLabel setTextColor: [UIColor whiteColor]];
        [_textLabel setNumberOfLines: 0];
        [_textLabel setLineBreakMode: NSLineBreakByCharWrapping];
        [_textLabel setShadowColor: [UIColor darkGrayColor]];
        [_textLabel setShadowOffset: CGSizeMake(1.0, 1.0f)];
    }
    return _textLabel;
}

- (UIAlertView *)alertView{
    if(!_alertView){
        _alertView = [[UIAlertView alloc] initWithTitle: @"Oops" message: @"" delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    }
    return _alertView;
}

#pragma mark -
- (id)init{
    self = [super init];
    if(self){
        [self setBackgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
        [self.layer setCornerRadius: 5.0f];
        [self.layer setMasksToBounds: YES];
        [self addSubview: self.textLabel];
    }
    return self;
}

#pragma mark - public method
/**
 *  show the specified message
 *  default duration is 2.0s
 *  @param text message
 */
- (void)showWithText:(NSString *) text{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showWithText: text duration: 2.0f];
    });
}
/**
 *  show the specified message
 *
 *  @param text     message
 *  @param duration The disappearance of time
 */
- (void)showWithText:(NSString *) text duration:(CGFloat) duration{
    if(IsStrEmpty(text)){
        return;
    }
    // Initialization code
    UIFont *font = [UIFont systemFontOfSize:16];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGSize size = CGSizeMake(SCREEN_WIDTH - 30.0f, SCREEN_HEIGHT);
    CGSize textSize = [text boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes: attributes context:nil].size;
    
    //update textLabel
    [self.textLabel setFrame: CGRectMake(10.0f, 10.0f, textSize.width, textSize.height)];
    [self.textLabel setText: text];
    [self.textLabel setFont: font];
    
    //update self
    CGRect frame;
    frame.size = CGSizeMake(textSize.width + 20.0f, textSize.height + 20.0f);
    frame.origin = CGPointMake((SCREEN_WIDTH - frame.size.width) / 2, SCREEN_HEIGHT - frame.size.height - TABBAR_HEIGHT - NAVIGATIONBAR_HEIGHT - 20.0f);
    [self setFrame: frame];
    [WINDOW addSubview:self];
    
    //timer
    NSTimer *timer = [NSTimer timerWithTimeInterval: duration  target:self selector:@selector(removeToastView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}

- (void)showAlertText:(NSString *) text{
    [self.alertView setTitle: @"Oops"];
    [self.alertView setMessage: text];
    [self.alertView show];
}

- (void)showAlertText:(NSString *) text withTitle: (NSString *)title{
    [self.alertView setTitle: title];
    [self.alertView setMessage: text];
    [self.alertView show];
}

#pragma mark － remove toastView
- (void)removeToastView{
    [UIView animateWithDuration: 0.5f animations:^{
        toastView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [toastView removeFromSuperview];
        toastView = nil;
    }];
}
@end
