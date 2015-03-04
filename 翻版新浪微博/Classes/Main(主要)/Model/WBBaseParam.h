//
//  WBBaseParam.h
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBaseParam : NSObject

/** 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得 */
@property (nonatomic,copy) NSString *access_token;
/** 当前授权用户的UID */
- (NSString *)getCurrUid;

@end
