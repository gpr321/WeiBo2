//
//  WBStatus.h
//  翻版新浪微博
//
//  Created by mac on 15-2-22.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBUser;

@interface WBStatus : NSObject

/**	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;
/**	string	微博信息内容*/
@property (nonatomic, copy) NSString *text;
/** 微博创建时间 */
@property (nonatomic,copy) NSString *created_at;
/** 微博来源 */
@property (nonatomic,copy) NSString *source;
/** 缩略图片地址，没有时不返回此字段 */
@property (nonatomic,copy) NSString *thumbnail_pic;
/** 中等尺寸图片地址，没有时不返回此字段 */
@property (nonatomic,copy) NSString *bmiddle_pic;
/** 原始图片地址，没有时不返回此字段 */
@property (nonatomic,copy) NSString *original_pic;

/** 微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url */
@property (nonatomic,strong) NSArray *pic_urls;

/**	object	微博作者的用户信息字段 详细*/
@property (nonatomic, strong) WBUser *user;

/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic,strong) WBStatus *retweeted_status;
/** 返回cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;

@end
