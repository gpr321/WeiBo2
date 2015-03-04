//
//  NSString+Regex.h
//  category
//
//  Created by mac on 15-2-7.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)

/**
 *  根据传进来的正则表达式判断当前字符串是否合法
 *
 *  @param regex 正则表达式
 *
 *  @return YES : 合法 ,否则 不合法
 */
- (BOOL)gp_matchWithRegex:(NSString *)regex;

/**
 *  从一段字符串中根据正则表达式匹配出符合条件的字符串,注意不能使用 ^ $进行单行匹配
 *
 *  @param regular 正则表达式
 *
 *  @return 符合条件的字符串数组
 */
- (NSArray *)gp_subStringByRegular:(NSString *)regular;

/**
 *  根据正则表达式匹配出子字符串,注意不能使用 ^ $进行单行匹配
 *
 *  @param regular 正则表达式
 *
 *  @return 符合条件的子字符串
 */
- (NSString *)gp_stringByRegular:(NSString *)regular;

/**
 *  用指定的正则表达式来遍历搜寻本字符串,每找到符合条件的会调用一次block
 *
 *  @param regular 正则表达式
 *  @param block   每找到符合条件的会调用一次block
 */
- (void)gp_findStringByRegular:(NSString *)regular usingBlock:(void(^)(NSString *item,NSRange range,BOOL *stop))block;
@end
