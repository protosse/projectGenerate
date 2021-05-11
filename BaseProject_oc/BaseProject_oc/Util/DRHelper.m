//
// Created by doom on 2018/7/11.
// Copyright (c) 2018 doom. All rights reserved.
//

#import "DRHelper.h"

void regCollectionClass(UICollectionView *collectionView, Class cellClass) {
    [collectionView registerClass:cellClass forCellWithReuseIdentifier:[cellClass className]];
}

void regTableClass(UITableView *tableView, Class cellClass) {
    [tableView registerClass:cellClass forCellReuseIdentifier:[cellClass className]];
}

void regCollectionNib(UICollectionView *collectionView, Class cellClass) {
    [collectionView registerNib:[UINib nibWithNibName:[cellClass className] bundle:nil] forCellWithReuseIdentifier:[cellClass className]];
}

void regTableNib(UITableView *tableView, Class cellClass) {
    [tableView registerNib:[UINib nibWithNibName:[cellClass className] bundle:nil] forCellReuseIdentifier:[cellClass className]];
}

void regSupplementaryClass(UICollectionView *collectionView, Class viewClass, NSString *supplementaryViewOfKind) {
    [collectionView registerClass:viewClass forSupplementaryViewOfKind:supplementaryViewOfKind withReuseIdentifier:[viewClass className]];
}

void regSupplementaryNib(UICollectionView *collectionView, Class viewClass, NSString *supplementaryViewOfKind) {
    [collectionView registerNib:[UINib nibWithNibName:[viewClass className] bundle:nil] forSupplementaryViewOfKind:supplementaryViewOfKind withReuseIdentifier:[viewClass className]];
}

void regHeaderFooterClass(UITableView *tableView, Class viewClass) {
    [tableView registerClass:viewClass forHeaderFooterViewReuseIdentifier:[viewClass className]];
}

void regHeaderFooterNib(UITableView *tableView, Class viewClass) {
    [tableView registerNib:[UINib nibWithNibName:[viewClass className] bundle:nil] forHeaderFooterViewReuseIdentifier:[viewClass className]];
}

@implementation DRHelper {

}
@end
