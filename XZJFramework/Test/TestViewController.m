//
//  TestViewController.m
//  XZJFramework
//
//  Created by Xiong, Zijun on 5/31/16.
//  Copyright © 2016 Xiong, Zijun. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(0.0f, 200.0f, SCREEN_WIDTH, 40.0f)];
    [button setTitle: [@([self.navigationController.viewControllers count]) stringValue] forState: UIControlStateNormal];
    [button setTitleColor:[UIColor textBlackColor] forState: UIControlStateNormal];
    [button addTarget: self action: @selector(nextButtonClick) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)nextButtonClick{
    TestViewController *nextVC = [[TestViewController alloc] init];
    [self.navigationController pushViewController: nextVC animated: YES];
}
@end
