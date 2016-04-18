//
//  BaseViewController.m
//  Giivv
//
//  Created by 熊梓君 on 16/4/7.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController
#pragma mark - load
- (id)init{
    self = [super init];
    if(self){
        /**
         *  initial viewContent's height
         */
        self.contentHeight = (SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor viewBackgroundColor]];
    /**
     *  Make the page layout from under the navigation bar
     */
    self.navigationController.navigationBar.translucent = NO;
    /**
     *  When using this way, when hidden TabBar will leave black bar at the bottom
     */
//    [self setEdgesForExtendedLayout: UIRectEdgeNone];
//    self.automaticallyAdjustsScrollViewInsets = NO;
}
@end
