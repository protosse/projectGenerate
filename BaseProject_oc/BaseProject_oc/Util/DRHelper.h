//
// Created by doom on 2018/7/11.
// Copyright (c) 2018 doom. All rights reserved.
//

#import <UIKit/UIKit.h>

void regCollectionClass(UICollectionView *collectionView, Class cellClass);

void regTableClass(UITableView *tableView, Class cellClass);

void regCollectionNib(UICollectionView *collectionView, Class cellClass);

void regTableNib(UITableView *tableView, Class cellClass);

void regSupplementaryClass(UICollectionView *collectionView, Class viewClass, NSString *supplementaryViewOfKind);

void regSupplementaryNib(UICollectionView *collectionView, Class viewClass, NSString *supplementaryViewOfKind);

void regHeaderFooterClass(UITableView *tableView, Class viewClass);

void regHeaderFooterNib(UITableView *tableView, Class viewClass);

@interface DRHelper : NSObject
@end
