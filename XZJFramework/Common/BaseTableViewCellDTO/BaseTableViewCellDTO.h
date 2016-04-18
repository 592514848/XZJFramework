//
//  BaseTableViewCellModel.h
//  Giivv
//
//  Created by 熊梓君 on 16/4/10.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTableViewCellDTO : NSObject
/**
 *  cell number
 */
@property (nonatomic, assign)NSInteger cellNo;

/**
 *  cell name
 */
@property (nonatomic, strong)NSString *cellName;

/**
 *  cell reuseIdentifier
 */
@property (nonatomic, strong)NSString *reuseIdentifier;

/**
 *  cell background color
 */
@property (nonatomic, strong)UIColor *cellColor;

/**
 *  Whether or not show header view
 */
@property (nonatomic, assign)BOOL isShowHeader;

/**
 *  cell's floor number
 */
@property (nonatomic, assign)NSInteger floorsNumber;

/**
 *  cell height
 */
@property (nonatomic, assign)CGFloat cellHeight;

/**
 *  cell section height
 */
@property (nonatomic, assign)CGFloat sectionHeight;

/**
 *  cell's datasource
 */
@property (nonatomic, strong)NSMutableArray *dataArray;
@end
