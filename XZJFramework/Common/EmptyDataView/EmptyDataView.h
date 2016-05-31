//
//  EmptyDataView.h
//  Giivv
//
//  Created by Xiong, Zijun on 5/18/16.
//  Copyright © 2016 Youdar . All rights reserved.
//
#define EMPTYDATAVIEW [EmptyDataView shareManager]
#import <UIKit/UIKit.h>

@interface EmptyDataView : UIView
+(EmptyDataView *)shareManager;

//
- (void)showTipInParentView: (UIView *) parentView text:(NSString *)text;

//
- (void)dismiss;
@end
