//
//  WBStatusCellUserInfoView.m
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

static CGFloat const kIconImgViewWH = 40;
static CGFloat const kArrowImgViewWH = 10;
static CGFloat const kVipImgViewWH = 20;
static CGFloat const kMargin = 10;

#define vipFontColor [UIColor orangeColor]
#define normalFontColor [UIColor blackColor]

#import "WBStatusCellUserInfoView.h"
#import "WBUser.h"
#import "WBStatus.h"
#import <UIView+AutoLayout.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface WBStatusCellUserInfoView ()

/** 用户头像图片 avatar_default_small */ 
@property (nonatomic,weak) UIImageView *iconImgView;
/** 呢称 */
@property (nonatomic,assign) UILabel *nameLabel;
/** vip */
@property (nonatomic,weak) UIImageView *vipImgView;
/** 发布时间label */
@property (nonatomic,weak) UILabel *publishTimeLabel;
/** 来源客户端 */
@property (nonatomic,weak) UILabel *sourceDeviceLabel;
/** 箭头 timeline_icon_more */
@property (nonatomic,weak) UIImageView *arrowImgView;

@end

@implementation WBStatusCellUserInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ) {
        [self setUpSubView];
    }
    return self;
}

#pragma mark - 初始化子控件
- (void)setUpSubView{
    // 头像
    UIImageView *iconImgView = [[UIImageView alloc] init];
    self.iconImgView = iconImgView;
    [self addSubview:iconImgView];
    [iconImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kMargin];
    [iconImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kMargin];
    [iconImgView autoSetDimensionsToSize:CGSizeMake(kIconImgViewWH, kIconImgViewWH)];
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    [nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:iconImgView withOffset:kMargin];
    [nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:iconImgView];
    // 箭头
    UIImageView *arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_icon_more"]];
    self.arrowImgView = arrowImgView;
    [self addSubview:arrowImgView];
    [arrowImgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kMargin];
    [arrowImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kMargin];
    [arrowImgView autoSetDimensionsToSize:CGSizeMake(kArrowImgViewWH, kArrowImgViewWH)];
  
    // vip
    UIImageView *vipImgView = [[UIImageView alloc] init];
    self.vipImgView = vipImgView;
    [self addSubview:vipImgView];
    [vipImgView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:nameLabel withOffset:kMargin];
    [vipImgView autoSetDimensionsToSize:CGSizeMake(kVipImgViewWH, kVipImgViewWH)];
    [vipImgView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:nameLabel];
    
    // 发布时间
    UILabel *publishTimeLabel = [[UILabel alloc] init];
    publishTimeLabel.font = [UIFont systemFontOfSize:13];
    publishTimeLabel.textColor = [UIColor lightGrayColor];
    self.publishTimeLabel = publishTimeLabel;
    [self addSubview:publishTimeLabel];
    [publishTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:iconImgView withOffset:kMargin];
    [publishTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameLabel withOffset:2];
    
    // 来源
    UILabel *sourceDeviceLabel = [[UILabel alloc] init];
    sourceDeviceLabel.font = [UIFont systemFontOfSize:13];
    sourceDeviceLabel.textColor = [UIColor lightGrayColor];
    self.sourceDeviceLabel = sourceDeviceLabel;
    [self addSubview:sourceDeviceLabel];
    [sourceDeviceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:publishTimeLabel withOffset:kMargin];
    [sourceDeviceLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:publishTimeLabel];
    
    [self autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:iconImgView];
}

- (void)setUser:(WBUser *)user{
    _user = user;
    NSURL *url = [NSURL URLWithString:user.profile_image_url];
    [self.iconImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.nameLabel.text = user.screen_name;
    if ( user.isVip ) {
        self.nameLabel.textColor = vipFontColor;
    } else {
        self.nameLabel.textColor = normalFontColor;
    }
    switch ( user.verified_type ) {
        case WBUserVerifiedPersonal: // 个人认证 avatar_vip
            self.vipImgView.hidden = NO;
            self.vipImgView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case WBUserVerifiedOrgEnterprice:   // 媒体官方
        case WBUserVerifiedOrgMedia:        // 网站官方
        case WBUserVerifiedOrgWebsite:      // 企业官方 avatar_enterprise_vip
            self.vipImgView.hidden = NO;
            self.vipImgView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case WBUserVerifiedDaren: // 微博达人 avatar_grassroot
            self.vipImgView.hidden = NO;
            self.vipImgView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            self.vipImgView.hidden = YES;
            break;
    }
    self.publishTimeLabel.text = self.user.status.created_at;
    self.sourceDeviceLabel.text = self.user.status.source;
    
    
}


@end
