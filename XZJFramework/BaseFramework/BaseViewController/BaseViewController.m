//
//  BaseViewController.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/7.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController
#pragma mark - load
- (id)init{
    self = [super init];
    if(self){
        /**
         *  初始化当前视图的高度
         */
        self.contentHeight = (SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor viewBackgroundColor]];
    /**
     *  设置视图布局的起始点从navigationBar底部开始
     */
    self.navigationController.navigationBar.translucent = NO;
}
@end
