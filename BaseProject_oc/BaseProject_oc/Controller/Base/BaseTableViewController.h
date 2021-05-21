//
//  BaseTableViewController.h
//  BaseProject_oc
//
//  Created by doom on 2018/7/9.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "BaseViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <MJRefresh/MJRefresh.h>
#import "ApiResponse.h"
#import "DRHelper.h"

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

/// default is plain, you can change to group in this method.
- (void)initTableView;

- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter;

- (RACSignal *)requestRemoteDataSignalWithPage:(NSInteger)page;

- (ApiResponse *)filterRemoteData:(id)value;

@end
