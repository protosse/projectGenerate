//
//  GVUserDefaults+Common.m
//  BaseProject_oc
//
//  Created by doom on 2018/7/23.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "GVUserDefaults+Common.h"

@implementation GVUserDefaults (Common)

@dynamic baseUrl;

- (void)removeAll {
    self.baseUrl = nil;
    [self removeLoginInfo];
}

- (void)removeLoginInfo {
}

- (NSDictionary *)setupDefaults {
    return @{};
}

@end
