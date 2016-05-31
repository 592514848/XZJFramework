//
//  BaseTableViewCellModel.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/10.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//

#import "BaseTableViewCellDTO.h"

@implementation BaseTableViewCellDTO
#pragma mark - init
- (id)init{
    self = [super init];
    if(self){
        self.dataArray = [NSMutableArray array];
    }
    return self;
}
@end
