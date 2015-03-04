//
//  WBBaseParam.m
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBBaseParam.h"
#import "WBAccountTool.h"
#import "WBAccount.h"

@implementation WBBaseParam

- (instancetype)init{
    if ( self = [super init] ) {
        self.access_token = [WBAccountTool account].access_token;
        if ( self.access_token == nil ) {
            return nil;
        }
    }
    return self;
}

- (NSString *)getCurrUid{
    return [WBAccountTool account].uid;
}

@end
