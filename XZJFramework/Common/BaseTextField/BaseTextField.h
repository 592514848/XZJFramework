//
//  BaseTextField.h
//  THJ
//
//  Created by Xiong, Zijun on 4/12/16.
//  Copyright © 2016 Youdar. All rights reserved.
//
typedef enum {
    kTextField_DefaultStyle = 0, ///default style
    kTextField_RoundRect = 1, ///round rect
    kTextField_LineStyle = 2
    /*
     ......
     */
}BaseTextField_Style;

#import <UIKit/UIKit.h>
@protocol BaseTextFieldObject_Delegate;
@class BaseTextFieldObject;
@interface BaseTextField : UITextField
/**
 *  The text box style
 */
@property (nonatomic, assign) BaseTextField_Style style;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, weak) id<BaseTextFieldObject_Delegate> baseDelegate;

- (void)setTextFiledRequest:(BOOL) isRequest;
@end


/**
 *  BaseTextFieldObject
 */

@interface BaseTextFieldObject : NSObject <UITextFieldDelegate>
@property(nonatomic, weak) id<BaseTextFieldObject_Delegate> delegate;

@property(nonatomic, assign) BaseTextField_Style style;
@end

@protocol BaseTextFieldObject_Delegate <NSObject>
@optional
- (BOOL)baseTextFieldShouldReturn:(UITextField *)textField;
@end
