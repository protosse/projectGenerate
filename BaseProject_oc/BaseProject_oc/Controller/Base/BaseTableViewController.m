//
//  BaseTableViewController.m
//  ShanjianUser
//
//  Created by doom on 2018/7/9.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)customInit {
    [super customInit];
    self.isFirstIn = NO;
    if (_isRequestDataOnViewDidLoad) {
        self.isFirstIn = YES;
        @weakify(self)
        [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
            @strongify(self)
            [self.requestCommand execute:@1];
        }];
    }
    _perPage = kDefaultTenPerPageNumber;
    _shouldInfiniteScrolling = _shouldPullToRefresh = _showDZNEmpty = YES;
}

- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    BOOL addConstraints = NO;
    if(!_tableView){
        [self initTableView];
        addConstraints = YES;
    }
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 200;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (_showDZNEmpty) {
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    _tableView.tableFooterView = [UIView new];

    if(addConstraints){
        [self.view addSubview:_tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.md_bottom);
        }];
    }
}

- (void)bindModel {
    [super bindModel];

    @weakify(self)
    [[[RACObserve(self, dataSource)
       distinctUntilChanged]
      deliverOnMainThread]
     subscribeNext:^(id x) {
         @strongify(self)
         [self.tableView reloadData];
     }];

    self.requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *p) {
        @strongify(self)
        self.page = MAX(1, p.intValue);
        return [[self requestRemoteDataSignalWithPage:self.page] takeUntil:self.rac_willDeallocSignal];
    }];

    [self.requestCommand.executing.deliverOnMainThread subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (self.isFirstIn && executing.boolValue) {
            [self showLoadingView];
        }
    }];

    [self.requestCommand.executionSignals.switchToLatest.deliverOnMainThread subscribeNext:^(id x) {
        @strongify(self)
        ApiResponse *response = [self filterRemoteData:x];
        NSArray *array = [response.data isKindOfClass:[NSArray class]] ? response.data : @[];
        if (self.isFirstIn) {
            [self hideLoadingView];
            self.isFirstIn = NO;
        }

        if(self.shouldInfiniteScrolling){
            self.shouldInfiniteScrolling = array.count >= 10;
        }

        if(self.page == 1){
            self.dataSource = array;
        } else {
            NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.dataSource];
            [mutableArray addObjectsFromArray:array];
            self.dataSource = mutableArray.copy;
        }

    }];

    [self.requestCommand.errors subscribeNext:^(id x) {
        @strongify(self)
        if (self.isFirstIn && self.loadingView) {
            [self.loadingView performFailure:^{
                @strongify(self)
                [self.requestCommand execute:@1];
            }];
        }
    }];

    if (_shouldPullToRefresh) {
        self.refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
        [[self.refreshControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
            @strongify(self)
            [[[self.requestCommand execute:@1] deliverOnMainThread]
             subscribeNext:^(id x) {
                 @strongify(self)
                 self.page = 1;
             } error:^(NSError *error) {
                 @strongify(self)
                 [self.refreshControl endRefreshing];
             }completed:^{
                 @strongify(self)
                 [self.refreshControl endRefreshing];
             }];
        }];
    }

    if(_shouldInfiniteScrolling){
        RAC(self, shouldInfiniteScrolling) = [[RACObserve(self, dataSource)
                                               deliverOnMainThread]
                                              map:^(NSArray *dataSource) {
                                                  @strongify(self)
                                                  NSUInteger count = dataSource.count;
                                                  return @(count >= self.perPage);
                                              }];
    }

    [[self.requestCommand.errors filter:[self requestRemoteDataErrorsFilter]] subscribe:self.errors];
}

- (ApiResponse *)filterRemoteData:(id)value {
    return value;
}

- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter {
    return ^BOOL(NSError *error) {
        return YES;
    };
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSInteger)page {
    return [RACSignal empty];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"暂无数据"];
}


- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.dataSource.count == 0;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

#pragma mark tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_shouldInfiniteScrolling) {
        if ((indexPath.row != 0 && indexPath.row == [self.dataSource count] - 1) || (indexPath.section != 0 && indexPath.section == [self.dataSource count] - 1)) {
            [self.requestCommand execute:@(self.page + 1)];
        }
    }
}

@end
