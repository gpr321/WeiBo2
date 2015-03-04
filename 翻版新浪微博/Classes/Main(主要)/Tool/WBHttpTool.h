//
//  WBHttpTool.h
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBHttpTool : NSObject

/**
 *  发送一个get请求
 *
 *  @param urlString    请求路径的字符串地址
 *  @param params       请求参数
 *  @param successBlock 成功的回调
 *  @param failBlock    失败的回调
 */
+ (void)getWithURL:(NSString *)urlString params:(NSDictionary *)params success:(void(^)(id result))successBlock failure:(void(^)(NSError *error))failBlock;

/**
 *  发送一个post请求
 *
 *  @param urlString    请求路径的字符串地址
 *  @param params       请求参数
 *  @param successBlock 成功的回调
 *  @param failBlock    失败的回调
 */
+ (void)postWithURL:(NSString *)urlString params:(NSDictionary *)params success:(void(^)(id result))successBlock failure:(void(^)(NSError *error))failBlock;

/**
 *  取消当前操作
 */
+ (void)cancelCurrResquest;

@end
