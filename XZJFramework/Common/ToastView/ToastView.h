//
//  ToastView.h
//  Giivv
//
//  Created by 熊梓君 on 16/4/9.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
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
@end
