//
//  WBMessageController.m
//  翻版新浪微博
//
//  Created by mac on 15-2-20.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBMessageController.h"

@interface WBMessageController ()

@end

@implementation WBMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WBGlobalColor;
    [self setUpNavigationBar];
}

#pragma mark - 初始化导航栏
- (void)setUpNavigationBar{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - 发私信
- (void)composeMsg{
    WBLog(@"%s",__FUNCTION__);
}

@end
