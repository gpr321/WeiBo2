//
//  WBBaseTool.m
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBBaseTool.h"
#import "WBHttpTool.h"
#import "GPJSonModel.h"

@implementation WBBaseTool

+ (void)getWithURL:(NSString *)urlString params:(id)params success:(void(^)(id result))successBlock failure:(void(^)(NSError *error))failBlock resultClass:(Class)resultClass{
    NSDictionary *paramDict = [params gp_dictionaryFromModel];
    [self getWithURL:urlString params:paramDict success:^(id result) {
        if ( [result isKindOfClass:[NSDictionary class]]  && successBlock) {
            successBlock([resultClass gp_objectWithDictionary:result]);
        }
    } failure:^(NSError *error) {
        if ( failBlock ) {
            failBlock(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)urlString params:(id)params success:(void(^)(id result))successBlock failure:(void(^)(NSError *error))failBlock resultClass:(Class)resultClass{
    NSDictionary *paramDict = [params gp_dictionaryFromModel];
    [self getWithURL:urlString params:paramDict success:^(id result) {
        if ( [result isKindOfClass:[NSDictionary class]] && successBlock ) {
            successBlock([resultClass gp_objectWithDictionary:result]);
        }
    } failure:^(NSError *error) {
        if ( failBlock ) {
            failBlock(error);
        }
    }];
}

@end
