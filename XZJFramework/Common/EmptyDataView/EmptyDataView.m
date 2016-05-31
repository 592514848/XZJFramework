//
//  EmptyDataView.m
//  Giivv
//
//  Created by Xiong, Zijun on 5/18/16.
//  Copyright © 2016 Youdar . All rights reserved.
//

#import "EmptyDataView.h"

@interface EmptyDataView()
@property(nonatomic, strong) UILabel *tipLabel;
@end

static EmptyDataView * mainView = nil;
@implementation EmptyDataView
#pragma mark - calss method
+(EmptyDataView *)shareManager{
    @synchronized(self) {
        if(mainView == nil){
            mainView = [[EmptyDataView alloc] init];
        }
    }
    return mainView;
}

#pragma mark - getters and setters
- (UILabel *)tipLabel{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] init];
        [_tipLabel setBackgroundColor: [UIColor clearColor]];
        [_tipLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [_tipLabel setTextColor: [UIColor textLightGrayColor]];
        [_tipLabel setTextAlignment: NSTextAlignmentCenter];
        [_tipLabel setNumberOfLines: 0];
        [_tipLabel setLineBreakMode: NSLineBreakByClipping];
    }
    return _tipLabel;
}


#pragma mark - public methods
- (void)showTipInParentView: (UIView *) parentView text:(NSString *)text{
    [mainView setHidden: NO];
    [parentView addSubview: mainView];
    //remove contains
    [mainView sd_clearAutoLayoutSettings];
    [self.tipLabel sd_clearAutoLayoutSettings];
    
    mainView.sd_layout
    .leftSpaceToView(parentView, 0.0f)
    .topSpaceToView(parentView, 0.0f)
    .rightSpaceToView(parentView, 0.0f)
    .bottomSpaceToView(parentView, 0.0f);
    
    [mainView addSubview: self.tipLabel];
    self.tipLabel.sd_layout
    .leftSpaceToView(mainView, 10.0f)
    .topSpaceToView(mainView, 10.0f)
    .rightSpaceToView(mainView, 10.0f)
    .bottomSpaceToView(mainView, 10.0f);
    
    [self.tipLabel setText: text];
}

- (void)dismiss{
    [mainView setHidden: YES];
    [self.tipLabel removeFromSuperview];
    self.tipLabel = nil;
}
@end
