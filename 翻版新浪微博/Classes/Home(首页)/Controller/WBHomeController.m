//
//  WBHomeController.m
//  翻版新浪微博
//
//  Created by mac on 15-2-20.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBHomeController.h"
#import "UIBarButtonItem+Button.h"
#import "WBHomeTitleButton.h"
#import "WBDropDownMenu.h"
#import "WBHomeMenuController.h"
#import <AFNetworking.h>
#import "WBAccountTool.h"
#import "WBAccount.h"
#import <MJRefresh.h>
#import "UIView+Frame.h"
#import "WBUser.h"
#import "WBBaseTool.h"
#import "WBUserParam.h"
#import "WBStatusTool.h"
#import "WBStatusParam.h"
#import "WBStatus.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "WBStatusResponse.h"
#import "WBUnReadCountParam.h"
#import "WBUnReadCount.h"
#import "WBStatusCell.h"

@interface WBHomeController ()<WBDropDownMenuDelegate>

@property (nonatomic,weak) UIButton *titleButton;

@property (nonatomic,strong) NSMutableArray *statuses;

@property (nonatomic,strong) WBStatusParam *statusParam;

@property (nonatomic,weak) NSTimer *timer;

@end

@implementation WBHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WBGlobalColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self loadUserInfo];
    [self setUpNavigationBar];
    [self setHeaderAndFooterRefresh];
     [self setUpUnReadStatusCount];
     [self updateUnReadCount];
    [self.tableView headerBeginRefreshing];
}

- (void)dealloc{
    [WBStatusTool cancelCurrResquest];
    [self.timer invalidate];
}

#pragma mark - 注册未读消息监听
- (void)setUpUnReadStatusCount{
    // 每隔一分钟访问一次
    NSTimeInterval interval = 60;
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(updateUnReadCount) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)updateUnReadCount{
    WBUnReadCountParam *param = [[WBUnReadCountParam alloc] init];
    [WBBaseTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:param success:^(WBUnReadCount *unReadCount) {
        [UIApplication sharedApplication].applicationIconBadgeNumber = unReadCount.status;
    } failure:^(NSError *error) {
        WBLog(@"请求出错-- %@",error);
    } resultClass:[WBUnReadCount class]];
}

#pragma mark - 数据集合的懒加载
- (NSMutableArray *)statuses{
    if ( _statuses == nil ) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (WBStatusParam *)statusParam{
    if ( _statusParam == nil ) {
        _statusParam = [[WBStatusParam alloc] init];
    }
    return _statusParam;
}

#pragma mark - 加载用户信息
- (void)loadUserInfo{
    WBUserParam *param = [[WBUserParam alloc] init];
    param.uid = [param getCurrUid];
    [WBBaseTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:param success:^(id user) {
        [self.titleButton setTitle:[user screen_name] forState:UIControlStateNormal];
    } failure:^(NSError *error) {
        WBLog(@"请求数据出错 - %@",error);
    } resultClass:[WBUser class]];
}

#pragma mark - 上下拉刷新
- (void)setHeaderAndFooterRefresh{
    [self.tableView addHeaderWithTarget:self action:@selector(loadUserData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreUserData)];
    self.tableView.headerRefreshingText = @"正在加载用户数据请稍等...";
    self.tableView.footerRefreshingText = @"正在帮你加载更多数据请稍等...";
}

- (void)showLoadStatusCount:(NSInteger)count{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = self.view.width;
    CGFloat labelHeight = 35;
    label.height = labelHeight;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    NSString *info = nil;
    if ( count ) {
        info = [NSString stringWithFormat:@"共有%ld条微博数据",count];
    } else {
        info = @"没有加载新的数据,请稍后重试";
    }
    label.text = info;
    label.y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - labelHeight;
    // 显示
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    label.alpha = 0.0;
    [UIView animateWithDuration:1.0 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            label.transform = CGAffineTransformIdentity;
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

#pragma mark - 加载 用户数据
- (void)loadUserData{
    [self.tableView footerEndRefreshing];
    [WBStatusTool cancelCurrResquest];
    WBStatusParam *params = self.statusParam;
    params.page = 1;
    [WBStatusTool getCurrStatusWith:params success:^(WBStatusResponse *response) {
        [self.statuses addObjectsFromArray:response.statuses];
        [self.tableView reloadData];
        [self showLoadStatusCount:response.statuses.count];
        [self.tableView headerEndRefreshing];
    } fail:^(NSError *error) {
        [self.tableView headerEndRefreshing];
        WBLog(@"失败了");
    }];
}

- (void)loadMoreUserData{
    [self.tableView headerEndRefreshing];
    [WBStatusTool cancelCurrResquest];
    [WBStatusTool cancelCurrResquest];
    WBStatusParam *params = self.statusParam;
    params.page++;
    [WBStatusTool getCurrStatusWith:params success:^(WBStatusResponse *response) {
        [self.statuses addObjectsFromArray:response.statuses];
        [self.tableView reloadData];
        [self showLoadStatusCount:response.statuses.count];
        [self.tableView footerEndRefreshing];
    } fail:^(NSError *error) {
        [self.tableView footerEndRefreshing];
        WBLog(@"失败了");
    }];
}

#pragma mark - 设置导航栏按钮
- (void)setUpNavigationBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem gp_barButtonItemWithImage:@"navigationbar_friendsearch" hightLightImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem gp_barButtonItemWithImage:@"navigationbar_pop" hightLightImage:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    UIButton *titleButton = [WBHomeTitleButton homeTitleButton];
    self.titleButton = titleButton;
    // 设置头部标题
    self.navigationItem.titleView = titleButton;
    [titleButton addTarget:self action:@selector(titleButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - tabBar按钮监听
- (void)friendSearch{
    WBLog(@"%s",__FUNCTION__);
}

- (void)pop{
    WBLog(@"%s",__FUNCTION__);
}

- (void)titleButtonDidClicked:(UIButton *)button{
    WBHomeMenuController *menuVC = [[WBHomeMenuController alloc] init];
    WBDropDownMenu *menu = [WBDropDownMenu dropDownMenu];
    menu.delegate = self;
    [menu showToView:button side:WBDropDownMenuShowDown withContentController:menuVC];
}

#pragma mark - WBDropDownMenuDelegate
- (void)dropDownMenuDidShow:(WBDropDownMenu *)menu{
    self.titleButton.selected = YES;
}

- (void)dropDownMenuDidDismiss:(WBDropDownMenu *)menu{
    self.titleButton.selected = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WBStatusCell *cell = [WBStatusCell statusCellWithTableView:tableView];
    WBStatus *status = self.statuses[indexPath.row];
    cell.status = status;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WBStatusCell *cell = [WBStatusCell statusCellWithTableView:tableView];
    WBStatus *status = self.statuses[indexPath.row];
    cell.status = status;
    return cell.cellHeight + kGlobalMargin + 20;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
}

@end
