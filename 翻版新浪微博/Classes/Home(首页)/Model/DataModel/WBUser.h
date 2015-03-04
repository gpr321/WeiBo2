//
//  WBUser.h
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBBaseParam.h"
@class WBStatus;

typedef NS_ENUM(NSInteger, WBUserVerifiedType) {
    WBUserVerifiedTypeNone = -1, // 没有任何认证
    
    WBUserVerifiedPersonal = 0,  // 个人认证
    
    WBUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    WBUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    WBUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    WBUserVerifiedDaren = 220 // 微博达人
};

@interface WBUser : WBBaseParam
/**	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;
/**	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;
/** 用户昵称 */
@property (nonatomic,copy) NSString *screen_name;
/** 用户头像地址（中图），50×50像素 */
@property (nonatomic,copy) NSString *profile_image_url;
/** 性别，m：男、f：女、n：未知 */
@property (nonatomic,copy) NSString *gender;
/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) NSInteger mbtype;
@property (nonatomic, assign, getter = isVip) BOOL vip;
/** 认证类型 */
@property (nonatomic,assign) WBUserVerifiedType verified_type;
/** 该用户的微博 */
@property (nonatomic,weak) WBStatus *status;
@end
