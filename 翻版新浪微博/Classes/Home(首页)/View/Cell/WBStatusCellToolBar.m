//
//  WBStatusToolBar.m
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#define kImageViewBackgroundHightLightImageName @"timeline_card_bottom_background_highlighted"
#define kImageViewBackgroundNormalImageName @"timeline_card_bottom_background"

#import "WBStatusCellToolBar.h"
#import <UIView+AutoLayout.h>

@interface WBStatusCellToolBar ()

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation WBStatusCellToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        [self setUpButtons];
    }
    return self;
}

- (void)setUpButtons{
    UIButton *repostBtn = [self buttonWithTitle:@"转发" iconImageName:@"timeline_icon_retweet"];
    self.repostBtn = repostBtn;
    [self addSubview:repostBtn];
    [repostBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeRight];
    
    UIButton *attitudeBtn = [self buttonWithTitle:@"赞" iconImageName:@"timeline_icon_unlike"];
    self.attitudeBtn = attitudeBtn;
    [self addSubview:attitudeBtn];
    [attitudeBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeLeft];
    
    UIButton *commentBtn = [self buttonWithTitle:@"评论" iconImageName:@"timeline_icon_comment"];
    self.commentBtn = commentBtn;
    [self addSubview:commentBtn];
    [commentBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:repostBtn];
    [commentBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:attitudeBtn];
    [commentBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [commentBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    [repostBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:commentBtn];
    [attitudeBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:commentBtn];
}

- (UIButton *)buttonWithTitle:(NSString *)title iconImageName:(NSString *)iconImageName{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:iconImageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:kImageViewBackgroundHightLightImageName] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:kImageViewBackgroundNormalImageName] forState:UIControlStateNormal];
    return button;
}


@end
