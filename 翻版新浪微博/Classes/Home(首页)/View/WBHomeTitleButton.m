//
//  WBHomeTitleButton.m
//  翻版新浪微博
//
//  Created by mac on 15-2-21.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#define kTitle @"首页"
#define kNormalImageName @"navigationbar_arrow_down"
#define kSelectedImageName @"navigationbar_arrow_up"
#define kMargin 10

#import "WBHomeTitleButton.h"
#import "UIView+Frame.h"

@implementation WBHomeTitleButton

+ (instancetype)homeTitleButton{
    WBHomeTitleButton *btn = [[WBHomeTitleButton alloc] init];
    [btn sizeToFit];
    btn.width += kMargin;
    return btn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ) {
        [self setUpButton];
    }
    return self;
}

- (void)setUpButton{
    [self setTitle:kTitle forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    UIImage *img = [UIImage imageNamed:kNormalImageName];
  
    [self setImage:img forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:kSelectedImageName] forState:UIControlStateSelected];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.x = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + kMargin;
}


@end
