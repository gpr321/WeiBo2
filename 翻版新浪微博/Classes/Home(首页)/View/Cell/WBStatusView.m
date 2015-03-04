//
//  WBOriginalView.m
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBStatusView.h"
#import "WBStatus.h"
#import <UIView+AutoLayout.h>
#import "WBImageView.h"
#import "WBPhotosView.h"

static CGFloat const kMargin = 8;

@interface WBStatusView ()
/** 微博的正文内容 */
@property (nonatomic,weak) UILabel *contentLabel;
@property (nonatomic,weak) WBPhotosView *photosView;

@end

@implementation WBStatusView

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ) {
        [self setUpSubViews];
    }
    return self;
}


#pragma mark - 初始化子控件
- (void)setUpSubViews{
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
    [self addSubview:contentLabel];
    [contentLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin) excludingEdge:ALEdgeBottom];
    
    WBPhotosView *photosView = [[WBPhotosView alloc] init];
    self.photosView = photosView;
    [self addSubview:photosView];
    
    [photosView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:contentLabel];
    [photosView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin)  excludingEdge:ALEdgeTop];
}

- (void)setOrignalStatus:(WBStatus *)orignalStatus{
    _orignalStatus = orignalStatus;
    self.contentLabel.text = orignalStatus.text;
    self.photosView.photos = orignalStatus.pic_urls;
}



@end
