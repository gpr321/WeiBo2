//
//  WBAccountTool.m
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"

#define accountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.arc"]

@implementation WBAccountTool

+ (void)saveAccount:(WBAccount *)account{
    NSString *accountPath = accountFilePath;
    WBLog(@"%@",accountPath);
    [NSKeyedArchiver archiveRootObject:account toFile:accountPath];
}

+ (WBAccount *)account{
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:accountFilePath];
    // 比较事件
    NSDate *now = [NSDate date];
    NSDate *expireDate = [account.create_date dateByAddingTimeInterval:account.expires_in.longLongValue];
    NSComparisonResult result = [expireDate compare:now];
    // expireDate <= now 过期
    // NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
    if ( result != NSOrderedDescending ) { // 不是升序就过期了
        return nil;
    }
    return account;
}

@end
