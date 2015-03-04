//
//  NSString+Regex.m
//  category
//
//  Created by mac on 15-2-7.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)

- (BOOL)gp_matchWithRegex:(NSString *)regex{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",regex];
    return [predicate evaluateWithObject:self];
}

- (NSArray *)gp_subStringByRegular:(NSString *)regular{
    NSRange r = [self rangeOfString:regular options:NSRegularExpressionSearch];
    if ( r.location == NSNotFound || r.length == 0 ) return nil;
    NSMutableArray *subStrings = [NSMutableArray array];
    NSString *item = nil;
    while (r.location != NSNotFound || r.length != 0 ) {
        item = [self substringWithRange:r];
        [subStrings addObject:item];
        r = [self rangeOfString:regular options:NSRegularExpressionSearch range:NSMakeRange(r.location + item.length, self.length - r.location - item.length)];
    }
    return subStrings;
}

- (NSString *)gp_stringByRegular:(NSString *)regular{
    NSRange r = [self rangeOfString:regular options:NSRegularExpressionSearch];
    if ( r.location == NSNotFound || r.length == 0 ) return nil;
    NSMutableString *subStrings = [NSMutableString string];
    NSString *item = nil;
    while (r.location != NSNotFound || r.length != 0 ) {
        item = [self substringWithRange:r];
        [subStrings appendString:item];
        r = [self rangeOfString:regular options:NSRegularExpressionSearch range:NSMakeRange(r.location + item.length, self.length - r.location - item.length)];
    }
    return [subStrings copy];
}

- (void)gp_findStringByRegular:(NSString *)regular usingBlock:(void(^)(NSString *item,NSRange range,BOOL *stop))block{
    NSRange r = [self rangeOfString:regular options:NSRegularExpressionSearch];
    NSString *item = nil;
    BOOL stop = NO;
    while (stop != YES && (r.location != NSNotFound || r.length != 0) ) {
        item = [self substringWithRange:r];
        block(item,r,&stop);
        r = [self rangeOfString:regular options:NSRegularExpressionSearch range:NSMakeRange(r.location + item.length, self.length - r.location - item.length)];
    }
}

@end
