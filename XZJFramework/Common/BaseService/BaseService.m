//
//  BaseService.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/10.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService
#pragma mark - getters and setters
- (NSMutableArray *)dataSourceArray{
    if(!_dataSourceArray){
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}
@end
