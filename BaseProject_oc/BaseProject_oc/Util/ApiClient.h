//
//  ApiClient.h
//  BaseProject_oc
//
//  Created by doom on 2018/7/25.
//  Copyright © 2018年 doom. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ApiClient : NSObject

@property(strong, nonatomic) AFHTTPSessionManager *apiManager;

+ (ApiClient *)shared;

@end
