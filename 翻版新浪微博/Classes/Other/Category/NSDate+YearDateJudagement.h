//
//  NSDate+YearDateJudagement.h
//  category
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YearDateJudagement)

/**
 *  判断某个时间是否为今年
 */
- (BOOL)gp_IsThisYear;

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)gp_IsYesterday;

/**
 *  判断某个时间是否为今天
 */
- (BOOL)gp_IsToday;

@end
