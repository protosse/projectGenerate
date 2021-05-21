//
//  ApiResponse.m
//  BaseProject_oc
//
//  Created by doom on 2018/7/25.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "ApiResponse.h"

@implementation ApiResponse

+ (instancetype)responseWithError:(NSError *)error {
    ApiResponse *model = [ApiResponse new];
    model.error = error;
    return model;
}

+ (instancetype)responseWithObject:(id)data {
    ApiResponse *model = [ApiResponse new];
    model.data = data;
    return model;
}

+ (instancetype)responseWithObject:(id)data error:(NSError *)error {
    ApiResponse *model = [ApiResponse new];
    model.data = data;
    model.error = error;
    return model;
}

@end
