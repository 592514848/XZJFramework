//
//  BaseTableViewController.h
//  Giivv
//
//  Created by 熊梓君 on 16/4/10.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//

#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface BaseTableViewController : BaseViewController<EGORefreshTableDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *mainTableView;
/**
 *  移除刷新视图
 */
- (void)removeRefreshHeaderView;

/**
 *  更新并创建上拉视图
 */
- (void)updateRefreshFooterView;

/**
 *  响应下拉刷新
 */
- (void)callbackForHeaderRefreshView;

/**
 *  响应上拉加载更多
 */
- (void)callbackForFooterRefreshView;
@end
