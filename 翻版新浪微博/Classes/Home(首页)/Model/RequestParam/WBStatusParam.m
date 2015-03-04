//
//  WBStatusParam.m
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBStatusParam.h"

@implementation WBStatusParam

- (instancetype)init{
    if ( self = [super init] ) {
        _count = 20;
        _page = 1;
    }
    return self;
}

/** 防止加载数据越界 */
- (NSInteger)count{
    NSInteger currCount = _curr_count;
    if ( currCount += _count > _max_count ) {
       _count = _max_count - _curr_count;
        currCount = _max_count;
    }
    _curr_count =currCount;
    return _count;
}

@end
