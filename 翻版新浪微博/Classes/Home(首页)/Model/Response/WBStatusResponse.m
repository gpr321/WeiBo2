//
//  WBStatusResponse.m
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBStatusResponse.h"
#import "GPJSonModel.h"
#import "WBStatus.h"

@implementation WBStatusResponse

+ (NSDictionary *)gp_objectClassesInArryProperties{
    return @{@"statuses" : [WBStatus class]};
}

GPDescription

@end
