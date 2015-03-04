//
//  WBStatusResponse.h
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBStatusResponse : NSObject

/** 返回微博的集合 class = WBStatus */
@property (nonatomic,strong) NSArray *statuses;

/** 微博的总条数 */
@property (nonatomic,assign) NSInteger total_number;

@end
