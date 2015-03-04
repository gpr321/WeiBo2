//
//  WBHttpTool.m
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBHttpTool.h"
#import <AFNetworking.h>

@implementation WBHttpTool

static AFHTTPRequestOperationManager *_manager = nil;
+ (void)initialize{
    _manager = [AFHTTPRequestOperationManager manager];
}

+ (void)getWithURL:(NSString *)urlString params:(NSDictionary *)params success:(void(^)(id result))successBlock failure:(void(^)(NSError *error))failBlock{
    [_manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ( successBlock ) {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ( failBlock ) {
            failBlock(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)urlString params:(NSDictionary *)params success:(void(^)(id result))successBlock failure:(void(^)(NSError *error))failBlock{
    [_manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ( successBlock ) {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ( failBlock ) {
            failBlock(error);
        }
    }];
}

+ (void)cancelCurrResquest{
    [_manager.operationQueue cancelAllOperations];
}

@end
