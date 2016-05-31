
//
//  BaseTabBarController.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/7.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//

#import "BaseTabBarController.h"
#import "TestViewController.h"

@interface BaseTabBarController()
@end

@implementation BaseTabBarController
#pragma mark - getters and setters
- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadViewControllers];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - load viewControllers
- (void)loadViewControllers{
    NSMutableArray *controllersArray = [NSMutableArray array];
    for(NSInteger i = 0; i < 2; i++){
        BaseNavigationController *navigationController = [[BaseNavigationController alloc] init];
        switch (i) {
            case 0:{
            }
            default:{
                TestViewController *homePageVC = [[TestViewController alloc] init];
                [homePageVC setTitle: @"Test"];
                [navigationController pushViewController: homePageVC animated: YES];
                break;
                break;
            }
        }
//        [navigationController.tabBarItem setImage: [[UIImage imageNamed:@"ic_product_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//        [navigationController.tabBarItem setSelectedImage: [[UIImage imageNamed:@"ic_product_pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [navigationController.tabBarItem setTitlePositionAdjustment: UIOffsetMake(0.0f, -4.0f)];
        [navigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
        [controllersArray addObject: navigationController];
    }
    [self setViewControllers: controllersArray];
}
@end
