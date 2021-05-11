//
//  BaseCollectionViewController.h
//  ShanjianUser
//
//  Created by doom on 2018/7/19.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "BaseViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <ODRefreshControl/ODRefreshControl.h>

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDelegate, UICollectionViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(nonatomic, assign) BOOL isRequestDataOnViewDidLoad;
@property(nonatomic, strong) RACCommand *requestCommand;
@property(nonatomic, assign) int page;
@property(nonatomic, assign) int perPage;
@property(nonatomic, assign) BOOL shouldPullToRefresh;
@property(nonatomic, assign) BOOL shouldInfiniteScrolling;
@property(nonatomic, assign) BOOL showDZNEmpty;

@property(nonatomic, copy) NSArray *dataSource;

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, strong) ODRefreshControl *refreshControl;


- (void)initCollectionView;

- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter;

- (ApiResponse *)filterRemoteData:(id)value;

- (RACSignal *)requestRemoteDataSignalWithPage:(NSInteger)page;

@end
