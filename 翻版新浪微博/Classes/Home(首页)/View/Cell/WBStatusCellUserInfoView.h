//
//  WBStatusCellUserInfoView.h
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBUser;

@interface WBStatusCellUserInfoView : UIView

/** 封装要显示的用户信息 */
@property (nonatomic,strong) WBUser *user;

@end
