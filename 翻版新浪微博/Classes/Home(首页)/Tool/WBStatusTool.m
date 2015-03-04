//
//  WBStatusTool.m
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBStatusTool.h"
#import "WBStatusParam.h"
#import "WBStatusResponse.h"
#import "WBStatus.h"

@implementation WBStatusTool

+ (void)getCurrStatusWith:(WBStatusParam *)param success:(void(^)(WBStatusResponse *response))successBlockk fail:(void(^)(NSError *error))failBlock{
    [self getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param success:^(WBStatusResponse *response) {
        if ( successBlockk ) {
            successBlockk(response);
        }
    } failure:^(NSError *error) {
        WBLog(@"请求动态数据失败 - %@",error);
        if ( failBlock ) {
            failBlock(error);
        }
    } resultClass:[WBStatusResponse class]];
}

@end
