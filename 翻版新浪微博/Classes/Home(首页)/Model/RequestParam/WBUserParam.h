//
//  WBUserParam.h
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBBaseParam.h"

@interface WBUserParam : WBBaseParam

/** 需要查询的用户ID。 */
@property (nonatomic,copy) NSString *uid;

@end
