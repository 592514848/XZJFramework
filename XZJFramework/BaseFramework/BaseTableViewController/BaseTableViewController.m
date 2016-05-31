//
//  BaseTableViewController.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/10.
//  Copyright © 2016年 Xiong, ZIjun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController()
@property(nonatomic, assign) BOOL reloading;
@property(nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property(nonatomic, strong) EGORefreshTableFooterView *refreshFooterView;
@end

@implementation BaseTableViewController
#pragma mark - getters and setters
- (EGORefreshTableHeaderView *)refreshHeaderView{
    if(!_refreshHeaderView){
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f , -self.mainTableView.height, self.mainTableView.width, self.mainTableView.height)];
        _refreshHeaderView.delegate = self;
    }
    return _refreshHeaderView;
}

- (UITableView *)mainTableView{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, self.contentHeight)];
        [_mainTableView setShowsVerticalScrollIndicator: NO];
        [_mainTableView setDelegate: self];
        [_mainTableView setDataSource: self];
        [_mainTableView setBackgroundColor: [UIColor viewBackgroundColor]];
        [self.mainTableView addSubview: self.refreshHeaderView];
        [self.refreshHeaderView refreshLastUpdatedDate];
        /**
         *  default footerView
         */
        UIView *footerView = [[UIView alloc] init];
        [footerView setBackgroundColor: [UIColor viewBackgroundColor]];
        [_mainTableView setTableFooterView: footerView];
    }
    return _mainTableView;
}

#pragma mark - load
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview: self.mainTableView];
}

#pragma mark - remove refreshHeaderView
- (void)removeRefreshHeaderView{
    if(IsNilOrNull(_refreshHeaderView)){
        return;
    }
    [_refreshHeaderView removeFromSuperview];
    _refreshHeaderView = nil;
}

#pragma mark - update and create footerView
-(void)updateRefreshFooterView{
    CGFloat height = MAX(self.mainTableView.contentSize.height, self.mainTableView.height) + self.mainTableView.top;
    if (_refreshFooterView && [_refreshFooterView superview]){
        _refreshFooterView.frame = CGRectMake(0.0f, height, self.mainTableView.width, SCREEN_HEIGHT);
    }
    else{
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height, self.mainTableView.width, SCREEN_HEIGHT)];
    }
    _refreshFooterView.delegate = self;
    [self.mainTableView addSubview:_refreshFooterView];
    [self finishReloadingData];
}

#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainTableView)
    {
        if (_refreshHeaderView)
        {
            [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        }
        if (_refreshFooterView)
        {
            [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == self.mainTableView)
    {
        if (_refreshHeaderView)
        {
            [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        }
        if (_refreshFooterView)
        {
            [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
        }
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView == self.mainTableView)
    {
        if (_refreshHeaderView)
        {
            [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        }
        if (_refreshFooterView)
        {
            [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
        }
    }
}

#pragma mark -
#pragma mark EGORefreshTable Delegate
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
    if (aRefreshPos == EGORefreshHeader){
        [self callbackForHeaderRefreshView];
    }
    else if(aRefreshPos == EGORefreshFooter){
        [self callbackForFooterRefreshView];
    }
    [self performSelector:@selector(finishReloadingData) withObject:nil afterDelay: 1.0f];
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
    return _reloading;
}

- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
    return [NSDate date];
}


#pragma mark - The data load method
- (void)finishReloadingData{
    _reloading = NO;
    if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading: self.mainTableView];
    }
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading: self.mainTableView];
    }
}

#pragma mark - public method
- (void)callbackForHeaderRefreshView{}

- (void)callbackForFooterRefreshView{}

#pragma mark - dealloc
- (void)dealloc{
}
@end
