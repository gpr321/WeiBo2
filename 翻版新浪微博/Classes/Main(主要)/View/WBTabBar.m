//
//  WBTabBar.m
//  翻版新浪微博
//
//  Created by mac on 15-2-21.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBTabBar.h"
#import "UIView+Frame.h"

#define kButtonCount 5

@interface WBTabBar ()

@property (nonatomic,weak) UIButton *addButton;
@property (nonatomic,assign) BOOL finishLayout;

@end

@implementation WBTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ) {
        UIButton *addButton = [[UIButton alloc] init];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        addButton.size = addButton.currentImage.size;
        self.addButton = addButton;
        [addButton addTarget:self action:@selector(addButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.width / kButtonCount;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger i = 0;
    for (UIView *item in self.subviews) {
        if ( [item isKindOfClass:NSClassFromString(@"UITabBarButton")] ) {
            x = i * w;
            item.frame = CGRectMake(x, y, w, h);
            i++;
        }
        if ( i == 2 ) {
            x = i * w;
            self.addButton.frame = CGRectMake(x, y, w, h);
            self.addButton.centerY = 0.5 * h;
            i++;
        }
    }
    self.finishLayout = YES;
}

- (void)addButtonDidClicked:(UIButton *)addButton{
    if ( [self.delegate respondsToSelector:@selector(tabBar:addButtonDidClicked:)] ) {
        [self.delegate tabBar:self addButtonDidClicked:addButton];
    }
}

@end
