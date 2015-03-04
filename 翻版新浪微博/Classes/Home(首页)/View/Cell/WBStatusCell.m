//
//  WBStatusCell.m
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#define kMargin 5

#import "WBStatusCell.h"
#import "WBStatusCellUserInfoView.h"
#import "WBStatusCellContentView.h"
#import "WBStatusCellToolBar.h"
#import <UIView+AutoLayout.h>
#import "WBStatus.h"
#import "UIView+Frame.h"

@interface WBStatusCell ()

/** 用来显示用户信息 */
@property (nonatomic,weak) WBStatusCellUserInfoView *userInfoView;
/** 用来显示用户信息 */
@property (nonatomic,weak) WBStatusCellContentView *statusContentView;
/** 用来显示用户信息 */
@property (nonatomic,weak) WBStatusCellToolBar *statusToolBar;

@end

@implementation WBStatusCell

- (void)setStatus:(WBStatus *)status{
    _status = status;
    self.userInfoView.user = status.user;
    self.statusContentView.status = status;
    [self.userInfoView setNeedsLayout];
    CGSize userInfoViewSize = [self layoutSizeWithView:self.userInfoView];
    CGSize statusContentViewSize = [self layoutSizeWithView:self.statusContentView];
    CGSize statusToolBarSize = [self layoutSizeWithView:self.statusToolBar];
    self.cellHeight = userInfoViewSize.height + statusContentViewSize.height + statusToolBarSize.height;
}

- (CGSize)layoutSizeWithView:(UIView *)view{
    [view setNeedsLayout];
    return [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

+ (instancetype)statusCellWithTableView:(UITableView *)tableView{
    WBStatusCell *cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self statusCellIdentifier]];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        [self setUpUserInfoView];
        [self setUpContentView];
        [self setUpToolBar];
    }
    return self;
}

+ (NSString *)statusCellIdentifier{
    return @"WBStatusCell";
}

/** 初始化发状状态信息显示控件 */
- (void)setUpContentView{
    WBStatusCellContentView *statusContentView = [[WBStatusCellContentView alloc] init];
    self.statusContentView = statusContentView;
    [self.contentView addSubview:statusContentView];
    [self.statusContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userInfoView withOffset:kGlobalMargin];
    [self.statusContentView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kMargin];
    [self.statusContentView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kMargin];
    
}

/** 初始化发状态的用户信息显示控件 */
- (void)setUpUserInfoView{
    WBStatusCellUserInfoView *userInfoView = [[WBStatusCellUserInfoView alloc] init];
    self.userInfoView = userInfoView;
    [self.contentView addSubview:userInfoView];
    [userInfoView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
}

/** 初始化工具条控件 */
- (void)setUpToolBar{
    WBStatusCellToolBar *statusToolBar = [[WBStatusCellToolBar alloc] init];
    self.statusToolBar = statusToolBar;
    [self.contentView addSubview:statusToolBar];
    [statusToolBar autoSetDimension:ALDimensionHeight toSize:44];
    [statusToolBar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [statusToolBar autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [statusToolBar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.statusContentView withOffset:0];
}




@end
