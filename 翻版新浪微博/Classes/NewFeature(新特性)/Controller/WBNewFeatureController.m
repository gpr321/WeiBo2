//
//  WBNewFeatureController.m
//  翻版新浪微博
//
//  Created by mac on 15-2-21.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#define kScrollViewPageCount 4
#define kNewFeatureNamePatten @"new_feature_%ld"

#import "WBNewFeatureController.h"
#import "UIView+Frame.h"
#import "WBTabBarController.h"

@interface WBNewFeatureController ()

@property (nonatomic,weak) UIScrollView *scrollView;

@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation WBNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpScrollView];
}

#pragma mark - 初始化 scrollView
- (void)setUpScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.frame = self.view.frame;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(self.view.width * kScrollViewPageCount, self.view.height);
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    UIImageView *itemImageView = nil;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = scrollView.width;
    CGFloat h = scrollView.height;
    NSString *imageName = nil;
    for (NSInteger i = 0; i < kScrollViewPageCount; i++) {
        imageName = [NSString stringWithFormat:kNewFeatureNamePatten,i + 1];
        itemImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        x = i * w;
        itemImageView.frame = CGRectMake(x, y, w, h);
        [scrollView addSubview:itemImageView];
        if ( i ==  kScrollViewPageCount - 1) {
            [self addItemButtonToImageView:itemImageView];
        }
    }
}

#pragma mark - 初始化最后一页的分享按钮
- (void)addItemButtonToImageView:(UIImageView *)imageView{
    imageView.userInteractionEnabled = YES;
    // 分享勾选按钮
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    shareButton.width = 300;
    shareButton.height = 30;
    shareButton.centerX = imageView.width * 0.5;
    shareButton.centerY = imageView.height * 0.65;
    [shareButton addTarget:self action:@selector(shareButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareButton];
    // 开始微博
    UIButton *startButton = [[UIButton alloc] init];
    [imageView addSubview:startButton];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = shareButton.centerX;
    startButton.centerY = imageView.height * 0.75;
    [startButton addTarget:self action:@selector(startButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 开始按钮被点击
- (void)startButtonDidClicked:(UIButton *)startButton{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[WBTabBarController alloc] init];
}

#pragma mark - 分享按钮被点击
- (void)shareButtonDidClicked:(UIButton *)shareButton{
    shareButton.selected = !shareButton.selected;
}

@end
