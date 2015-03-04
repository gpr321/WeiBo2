//
//  WBAccount.h
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject<NSCoding>

/** 用于调用access_token，接口获取授权后的access token */
@property (nonatomic,copy) NSString *access_token;
/** access_token的生命周期，单位是秒数 */
@property (nonatomic,strong) NSNumber *expires_in;
/** access_token的生命周期（该参数即将废弃，开发者请使用expires_in） */
@property (nonatomic,strong) NSNumber *remind_in;
/** 当前授权用户的UID */
@property (nonatomic,copy) NSString*uid;
/** 该token的创建日期 */
@property (nonatomic,strong) NSDate *create_date;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
