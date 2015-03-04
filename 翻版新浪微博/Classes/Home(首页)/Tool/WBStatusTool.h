//
//  WBStatusTool.h
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBBaseTool.h"
@class WBStatusParam,WBStatusResponse;

@interface WBStatusTool : WBBaseTool

/**
 *  获取当前用户的动态信息
 *
 *  @param param         请求信息
 *  @param successBlockk 请求成功的回调 数组元素class = WBStatus
 *  @param failBlock     请求失败的回调
 */
+ (void)getCurrStatusWith:(WBStatusParam *)param success:(void(^)(WBStatusResponse *response))successBlockk fail:(void(^)(NSError *error))failBlock;

@end
