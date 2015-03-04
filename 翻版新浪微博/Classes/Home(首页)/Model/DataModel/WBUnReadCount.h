//
//  WBUnReadCountResponse.h
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUnReadCount : NSObject

/** 新微博未读数 */
@property (nonatomic,assign) NSInteger status;
/** 新粉丝数 */
@property (nonatomic,assign) NSInteger follower;
/** 新评论数 */
@property (nonatomic,assign) NSInteger cmt;
/** 新私信数 */
@property (nonatomic,assign) NSInteger dm;
/** 新提及我的微博数 */
@property (nonatomic,assign) NSInteger mention_status;
/** 新提及我的评论数 */
@property (nonatomic,assign) NSInteger mention_cmt;
/** 微群消息未读数 */
@property (nonatomic,assign) NSInteger group;
/** 私有微群消息未读数 */
@property (nonatomic,assign) NSInteger private_group;
/** 新通知未读数 */
@property (nonatomic,assign) NSInteger notice;
/** 新邀请未读数 */
@property (nonatomic,assign) NSInteger invite;
/** 新勋章数 */
@property (nonatomic,assign) NSInteger badge;
/** 相册消息未读数 */
@property (nonatomic,assign) NSInteger photo;
/** {{{3}}} */
@property (nonatomic,assign) NSInteger msgbox;


@end
