//
//  ApiClient.m
//  BaseProject_oc
//
//  Created by doom on 2018/7/25.
//  Copyright © 2018年 doom. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "ApiClient.h"
#import "ApiResponse.h"

typedef enum {
    Get = 0,
    Post,
} RequestType;

@implementation ApiClient

static ApiClient *_sharedClient = nil;
static dispatch_once_t onceToken;

+ (ApiClient *)shared {
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ApiClient alloc] init];
    });
    return _sharedClient;
}

#pragma mark - base

- (RACSignal *)createImageUploadSignalRequest:(NSString *)method modelClass:(NSString *)className params:(NSDictionary *)params images:(NSArray *)images name:(NSString *)name {
    @weakify(self)
    return [[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        @strongify(self)
        DLog(@"%@ params -> %@", method, params);
        NSString *url = [[NSURL URLWithString:method relativeToURL:[NSURL URLWithString:[GVUserDefaults standardUserDefaults].baseUrl]] absoluteString];
        NSURLSessionTask *task = [self.apiManager POST:url parameters:params headers:nil constructingBodyWithBlock:^(id <AFMultipartFormData> _Nonnull formData) {
            for (int i = 0; i < images.count; i++) {
                NSData *imageData = UIImageJPEGRepresentation(images[i], 0.5);
                NSDate *date = [NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *dateString = [formatter stringFromDate:date];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", dateString];

                if (images.count == 1) {
                    [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpg/png/jpeg"];
                } else {
                    NSString *temp = [NSString stringWithFormat:@"%@[%d]", name, i];
                    [formData appendPartWithFileData:imageData name:temp fileName:fileName mimeType:@"image/jpg/png/jpeg"];
                }
            }
        } progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            DLog(@"%@ response -> %@", method, [responseObject description]);
            ApiResponse *apiResponse = [self mappedDataFromResponseObject:responseObject className:className];
            apiResponse.statusCode = ((NSHTTPURLResponse *) task.response).statusCode;
            if (apiResponse.error == nil) {
                [subscriber sendNext:apiResponse];
                [subscriber sendCompleted];
            } else {
                [subscriber sendError:apiResponse.error];
            }
        } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            [subscriber sendError:error];
        }];
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] replayLazily];
}

- (RACSignal *)createSignalRequestWithMethod:(NSString *)method requestType:(RequestType)requestType className:(NSString *)className params:(NSDictionary *)params {
    @weakify(self)
    return [[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        @strongify(self)
        DLog(@"%@ params -> %@", method, params);
        NSURLSessionDataTask *task;
        NSString *url = [[NSURL URLWithString:method relativeToURL:[NSURL URLWithString:[GVUserDefaults standardUserDefaults].baseUrl]] absoluteString];
        switch (requestType) {
            case Get: {
                task = [self.apiManager GET:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                    @strongify(self)
                    DLog(@"%@ response -> %@", method, [responseObject description]);
                    ApiResponse *apiResponse = [self mappedDataFromResponseObject:responseObject className:className];
                    apiResponse.statusCode = ((NSHTTPURLResponse *) task.response).statusCode;
                    if (apiResponse.error == nil) {
                        [subscriber sendNext:apiResponse];
                        [subscriber sendCompleted];
                    } else {
                        [subscriber sendError:apiResponse.error];
                    }
                } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                    [subscriber sendError:error];
                }];
                break;
            }
            case Post: {
                task = [self.apiManager POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                    @strongify(self)
                    DLog(@"%@ response -> %@", method, [responseObject description]);
                    ApiResponse *apiResponse = [self mappedDataFromResponseObject:responseObject className:className];
                    apiResponse.statusCode = ((NSHTTPURLResponse *) task.response).statusCode;
                    if (apiResponse.error == nil) {
                        [subscriber sendNext:apiResponse];
                        [subscriber sendCompleted];
                    } else {
                        [subscriber sendError:apiResponse.error];
                    }
                } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                    [subscriber sendError:error];
                }];
                break;
            }
        }

        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] replayLazily];
}

#pragma mark - Data response mapping

- (ApiResponse *)mappedDataFromResponseObject:(id)object className:(NSString *)className {
    Class modelClass = NSClassFromString(className);
    id mappedObject;
    if ([object isKindOfClass:[NSDictionary class]]) {
        id data = object[@"data"];
        id code = object[@"errcode"];
        NSString *message = @"";
        if ([object[@"msg"] isKindOfClass:[NSString class]]) {
            message = object[@"msg"];
        }

        if (code) {
            if ([code integerValue] == 200) {
                if ([data isKindOfClass:[NSArray class]]) {
                    NSArray *array = data;
                    if (modelClass == [NSNull class] || modelClass == nil) {
                        mappedObject = array;
                    } else {
                        mappedObject = [NSArray modelArrayWithClass:modelClass json:data];
                    }
                } else if ([data isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dic = data;
                    if (modelClass == [NSNull class] || modelClass == nil) {
                        mappedObject = dic;
                    } else {
                        mappedObject = [modelClass modelWithJSON:dic];
                    }
                } else {
                    if (![data isKindOfClass:[NSNull class]]) {
                        mappedObject = data;
                    }
                }
            } else if ([code integerValue] == 401) {
                [NSObject changeToLogin];
                return [ApiResponse responseWithError:[[NSError alloc] initWithDomain:@"" code:[code integerValue] userInfo:@{NSLocalizedDescriptionKey: message}]];
            } else {
                NSMutableDictionary *dic = @{}.mutableCopy;
                dic[NSLocalizedDescriptionKey] = message;
                if (data != nil) {
                    dic[@"data"] = data;
                }
                return [ApiResponse responseWithError:[[NSError alloc] initWithDomain:@"" code:[code integerValue] userInfo:dic]];
            }
        } else {
            return [ApiResponse responseWithError:[[NSError alloc] initWithDomain:@"" code:0 userInfo:[message isKindOfClass:[NSString class]] ? @{NSLocalizedDescriptionKey: message} : nil]];
        }
    } else if ([object isKindOfClass:[NSArray class]]) {
        mappedObject = [NSArray modelArrayWithClass:modelClass json:object];
    }

    return [ApiResponse responseWithObject:mappedObject];
}

#pragma mark - setup

- (AFHTTPSessionManager *)apiManager {
    if (!_apiManager) {
        _apiManager = [AFHTTPSessionManager manager];
        [_apiManager.requestSerializer setHTTPShouldHandleCookies:YES];
        _apiManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _apiManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
        _apiManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _apiManager.requestSerializer.timeoutInterval = 30;
        _apiManager.responseSerializer.acceptableContentTypes = [_apiManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }

//    NSString *token = [GVUserDefaults standardUserDefaults].token;
//    [_apiManager.requestSerializer setValue:token ?: @"" forHTTPHeaderField:@"access-token"];
    return _apiManager;
}

@end
