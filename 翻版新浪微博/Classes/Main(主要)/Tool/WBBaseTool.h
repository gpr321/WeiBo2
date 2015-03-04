//
//  WBBaseTool.h
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBHttpTool.h"

@interface WBBaseTool : WBHttpTool

/**
 *  向一个路径发送一个 GET 请求,不过参数为一个 Model 类型
 *
 *  @param urlString    请求路径
 *  @param params       请求参数的Model类型
 *  @param successBlock 成功的回调
 *  @param failBlock    失败的回调
 *  @param resultClass  请求结果的类型
 */
+ (void)getWithURL:(NSString *)urlString params:(id)params success:(void(^)(id result))successBlock failure:(void(^)(NSError *error))failBlock resultClass:(Class)resultClass;

/**
 *  向一个路径发送一个 POST 请求,不过参数为一个 Model 类型
 *
 *  @param urlString    请求路径
 *  @param params       请求参数的Model类型
 *  @param successBlock 成功的回调
 *  @param failBlock    失败的回调
 *  @param resultClass  请求结果的类型
 */
+ (void)postWithURL:(NSString *)urlString params:(id)params success:(void(^)(id result))successBlock failure:(void(^)(NSError *error))failBlock resultClass:(Class)resultClass;

@end
