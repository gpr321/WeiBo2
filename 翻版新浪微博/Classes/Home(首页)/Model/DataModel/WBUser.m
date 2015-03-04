//
//  WBUser.m
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBUser.h"
#import "GPJSonModel.h"

@implementation WBUser

- (void)setMbtype:(NSInteger)mbtype{
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}

GPDescription

@end
