//
//  BaseTableViewController.h
//  ShanjianUser
//
//  Created by doom on 2018/7/9.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "BaseViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <ODRefreshControl/ODRefreshControl.h>

@interface BaseTableViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(nonatomic, assign) BOOL isRequestDataOnViewDidLoad;

@property(nonatomic, strong) RACCommand *requestCommand;
@property(nonatomic, assign) int page;
@property(nonatomic, assign) int perPage;
@property(nonatomic, assign) BOOL shouldPullToRefresh;
@property(nonatomic, assign) BOOL shouldInfiniteScrolling;
@property(nonatomic, assign) BOOL showDZNEmpty;

@property(nonatomic, copy) NSArray *dataSource;

@property(nonatomic, strong) IBOutlet UITableView *tableView;
@property(nonatomic, strong) ODRefreshControl *refreshControl;


/// default is plain, you can change to group in this method.
- (void)initTableView;

- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter;

- (RACSignal *)requestRemoteDataSignalWithPage:(NSInteger)page;

- (ApiResponse *)filterRemoteData:(id)value;

@end
