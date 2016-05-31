//
//  BaseTableViewCellModel.h
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/10.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTableViewCellDTO : NSObject
/**
 *  cell 的序号
 */
@property (nonatomic, assign)NSInteger cellNo;

/**
 *  cell 名称
 */
@property (nonatomic, strong)NSString *cellName;

/**
 *  cell 重用ID
 */
@property (nonatomic, strong)NSString *reuseIdentifier;

/**
 *  cell 背景颜色
 */
@property (nonatomic, strong)UIColor *cellColor;

/**
 *  是否显示Header
 */
@property (nonatomic, assign)BOOL isShowHeader;

/**
 *  cell的层数
 */
@property (nonatomic, assign)NSInteger floorsNumber;

/**
 *  cell 高度
 */
@property (nonatomic, assign)CGFloat cellHeight;

/**
 *  cell section 的高度
 */
@property (nonatomic, assign)CGFloat sectionHeight;

/**
 *  cell 数据源
 */
@property (nonatomic, strong)NSMutableArray *dataArray;
@end
