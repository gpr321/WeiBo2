//
//  WBDiscoverController.m
//  翻版新浪微博
//
//  Created by mac on 15-2-20.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBDiscoverController.h"
#import "UIView+Frame.h"
#import "WBSearchBar.h"

@interface WBDiscoverController ()

@end

@implementation WBDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WBGlobalColor;
    [self setUpTitleView];
}

#pragma mark - 初始化头部标题
- (void)setUpTitleView{
    WBSearchBar *searchBar = [WBSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
}

@end
