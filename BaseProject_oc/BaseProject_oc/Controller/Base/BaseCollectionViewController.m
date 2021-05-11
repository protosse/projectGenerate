//
//  BaseCollectionViewController.m
//  ShanjianUser
//
//  Created by doom on 2018/7/19.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

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
    _perPage = 10;
    _shouldInfiniteScrolling = _shouldPullToRefresh = _showDZNEmpty = YES;
}

- (void)initCollectionView {
    _flowLayout = [UICollectionViewFlowLayout new];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    BOOL addConstraints = NO;
    if(!_collectionView){
        [self initCollectionView];
        addConstraints = YES;
    }
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (_showDZNEmpty) {
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
    }

    if(addConstraints){
        [self.view addSubview:_collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
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
         [self.collectionView reloadData];
     }];

    self.requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *p) {
        @strongify(self)
        self.page = p.intValue;
        return [[self requestRemoteDataSignalWithPage:self.page] takeUntil:self.rac_willDeallocSignal];
    }];

    [self.requestCommand.executing.deliverOnMainThread subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (self.isFirstIn && executing.boolValue) {
            [self showLoadingView];
        }
    }];

    [self.requestCommand.executionSignals.switchToLatest.deliverOnMainThread subscribeNext:^(id x) {
        ApiResponse *response = [self filterRemoteData:x];
        NSArray *array = [response.data isKindOfClass:[NSArray class]] ? response.data : @[];
        @strongify(self)
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
        self.refreshControl = [[ODRefreshControl alloc] initInScrollView:self.collectionView];
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

- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter {
    return ^BOOL(NSError *error) {
        return YES;
    };
}

- (ApiResponse *)filterRemoteData:(id)value {
    return value;
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

#pragma mark collectionView dataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_shouldInfiniteScrolling) {
        if (indexPath.row != 0 && indexPath.row == [self.dataSource count] - 1) {
            [self.requestCommand execute:@(self.page + 1)];
        }
    }
}

@end
