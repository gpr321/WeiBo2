//
//  WBStatus.m
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBStatus.h"
#import "GPJSonModel.h"
#import "WBUser.h"
#import "NSDate+YearDateJudagement.h"
#import "NSString+Regex.h"
#import "WBPhoto.h"

@implementation WBStatus

- (NSString *)created_at{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 真机调试的时候要转化时区到欧美时区
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [fmt dateFromString:_created_at];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *component = [calendar components:unit fromDate:createDate toDate:[NSDate date] options:0];
    NSString *created_at = nil;
    if ( [createDate gp_IsThisYear] ) {
        if ( [createDate gp_IsToday] ) {
            if ( component.hour > 0 ) {
                created_at = [NSString stringWithFormat:@"%ld小时前",component.hour];
            } else if ( component.minute > 0 ) {
                created_at = [NSString stringWithFormat:@"%ld分钟前",component.minute];
            } else {
                created_at = @"刚刚";
            }
        } else if ( [createDate gp_IsYesterday] ) {
            fmt.dateFormat = @"HH:mm";
            created_at = [fmt stringFromDate:createDate];
            created_at = [NSString stringWithFormat:@"昨天 %@",created_at];
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
            created_at = [fmt stringFromDate:createDate];
        }
    } else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        created_at = [fmt stringFromDate:createDate];
    }
    return  created_at;
}

- (void)setUser:(WBUser *)user{
    _user = user;
    user.status = self;
}

- (NSString *)source{
    NSString *subString = [_source gp_stringByRegular:@">\\w*<"];
    return [subString substringWithRange:NSMakeRange(1, subString.length - 2)];
}

+ (NSDictionary *)gp_objectClassesInArryProperties{
    return @{ @"pic_urls" : [WBPhoto class] };
}

GPDescription
@end
