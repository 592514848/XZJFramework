//
//  BaseTextView.m
//  Giivv
//
//  Created by Xiong, Zijun on 4/20/16.
//  Copyright © 2016 Youdar . All rights reserved.
//

#import "BaseTextView.h"

@interface BaseTextView () <UITextViewDelegate>
@property(nonatomic, strong) UIColor *fontColor;
@property(nonatomic, strong) NSString *placeholderText;
@end

@implementation BaseTextView
#pragma mark - init
- (instancetype)init{
    self = [super init];
    if(self){
        [self setDelegate: self];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setDelegate: self];
    }
    return self;
}

#pragma mark - overwrite
- (NSString *)text{
    if([[super text] isEqualToString: self.placeholderText]){
        return @"";
    }
    return [super text];
}

- (void)setTextColor:(UIColor *)textColor{
    [super setTextColor:textColor];
    self.fontColor = textColor;
}

#pragma mark - textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([[super text] isEqualToString: self.placeholderText]){
        [textView setText: @""];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([[super text] length] <= 0){
        [textView setText: self.placeholderText];
    }
}

#pragma mark - pblic method
#pragma mark setting placeholder
- (void)setPlaceholder:(NSString * _Nullable) placeholder{
    self.placeholderText = placeholder;
    [self setText: placeholder];
    [self setTextColor: [UIColor lightGrayColor]];
}
@end
