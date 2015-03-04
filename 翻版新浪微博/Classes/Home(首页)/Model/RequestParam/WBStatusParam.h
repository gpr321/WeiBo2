//
//  WBStatusParam.h
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBBaseParam.h"

@interface WBStatusParam : WBBaseParam

/** 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0 */
@property (nonatomic,assign) NSInteger since_id;
/** 若指定此参数，则返回ID小于或等于max_id的微博，默认为0 */
@property (nonatomic,assign) NSInteger max_id;
/** 单页返回的记录条数，最大不超过100，默认为20 */
@property (nonatomic,assign) NSInteger count;
/** 返回结果的页码，默认为1 */
@property (nonatomic,assign) NSInteger page;
/** 过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0 */
@property (nonatomic,assign) NSInteger feature;
/** 返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0 */
@property (nonatomic,assign) NSInteger trim_user;

/** 当前已经加载的总条数 */
@property (nonatomic,assign) NSInteger curr_count;
/** 当前用户的微博总数 */
@property (nonatomic,assign) NSInteger max_count;

@end
