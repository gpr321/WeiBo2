//
//  WBMeController.m
//  翻版新浪微博
//
//  Created by mac on 15-2-20.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBMeController.h"
#import "WBTestController.h"

@interface WBMeController ()

@end

@implementation WBMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WBGlobalColor;
    [self setUpNavigationBar];
}

#pragma mark - 初始化导航栏
- (void)setUpNavigationBar{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingBarButtonDidClicked)];
}

#pragma mark - 设置
- (void)settingBarButtonDidClicked{
    WBTestController *testVC = [[WBTestController alloc] init];
    [self.navigationController pushViewController:testVC animated:YES];
}
@end
