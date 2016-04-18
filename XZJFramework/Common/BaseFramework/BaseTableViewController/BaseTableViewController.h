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
 *  remove refreshHeaderView
 */
- (void)removeRefreshHeaderView;

/**
 *  update and create footerView
 */
- (void)updateRefreshFooterView;

/**
 *  The drop-down refresh the callback
 */
- (void)callbackForHeaderRefreshView;

/**
 *  Pull-up loads more callback
 */
- (void)callbackForFooterRefreshView;
@end
