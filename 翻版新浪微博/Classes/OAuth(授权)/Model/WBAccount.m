//
//  WBAccount.m
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBAccount.h"
#import "GPJSonModel.h"

@implementation WBAccount

- (instancetype)init{
    if ( self = [super init] ) {
        self.create_date = [NSDate date];
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    return [self gp_objectWithDictionary:dict];
}

GPDescription
GPObjectCoding

@end
