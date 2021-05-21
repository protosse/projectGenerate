//
//  GVUserDefaults+Common.h
//  BaseProject_oc
//
//  Created by doom on 2018/7/23.
//  Copyright © 2018年 doom. All rights reserved.
//

#import <GVUserDefaults/GVUserDefaults.h>

@interface GVUserDefaults (Common)

@property(nonatomic, weak) NSString *baseUrl;

- (void)removeAll;

- (void)removeLoginInfo;

@end
