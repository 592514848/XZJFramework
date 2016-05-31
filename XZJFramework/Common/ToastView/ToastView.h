//
//  ToastView.h
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/9.
//  Copyright © 2016 Youdar. All rights reserved.
//

#define TOASTVIEW [ToastView shareManager]
#import <UIKit/UIKit.h>

@interface ToastView : UIView
/**
 *  public method
 */
+(ToastView *)shareManager;
- (void)showWithText:(NSString *) text;
- (void)showWithText:(NSString *) text duration:(CGFloat) duration;
- (void)showAlertText:(NSString *) text;
- (void)showAlertText:(NSString *) text withTitle: (NSString *)title;
@end
