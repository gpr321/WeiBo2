//
//  WBStatusContentView.m
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBStatusCellContentView.h"
#import "WBStatusView.h"
#import "WBStatusRetweetView.h"
#import "WBStatus.h"
#import "UIView+Frame.h"
#import <UIView+AutoLayout.h>

@interface WBStatusCellContentView ()

@property (nonatomic,weak) WBStatusView *orignalView;

@property (nonatomic,weak) WBStatusView *retweetView;

@end

@implementation WBStatusCellContentView

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    WBStatusView *orignalView = [[WBStatusView alloc] init];
    self.orignalView = orignalView;
    [self addSubview:orignalView];
    [orignalView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
    WBStatusView *retweetView = [[WBStatusView alloc] init];
    retweetView.backgroundColor = GPARGB(1, 240, 240, 240);
    self.retweetView = retweetView;
    [self addSubview:retweetView];
    [retweetView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:orignalView];
    [retweetView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [retweetView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    
    [self autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:retweetView withOffset:10];
}

- (void)setStatus:(WBStatus *)status{
    _status = status;
    self.orignalView.orignalStatus = status;
    if ( status.retweeted_status ) {
        self.retweetView.hidden = NO;
        self.retweetView.orignalStatus = status.retweeted_status;
    } else {
        self.retweetView.hidden = YES;
    }
}

@end
