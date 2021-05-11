//
//  ApiResponse.h
//  ZhiYiCe
//
//  Created by doom on 2018/7/25.
//  Copyright © 2018年 doom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiResponse : NSObject

@property (assign, nonatomic) NSInteger statusCode;
@property (strong, nonatomic) NSError *error;
@property (strong, nonatomic) id data;

+ (instancetype)responseWithError:(NSError *)error;
+ (instancetype)responseWithObject:(id)data;
+ (instancetype)responseWithObject:(id)data error:(NSError *)error;

@end
