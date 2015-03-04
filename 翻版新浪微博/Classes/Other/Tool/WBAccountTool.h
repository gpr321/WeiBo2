//
//  WBAccountTool.h
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBAccount;

@interface WBAccountTool : NSObject

/**
 *  保存账户对象到沙盒中
 *
 *  @param account 要保存的账户对象
 */
+ (void)saveAccount:(WBAccount *)account;

/**
 *  从沙河中取出保存的账户对象,如果过期的话会返回空
 *
 *  @return 账户对象
 */
+ (WBAccount *)account;

@end
