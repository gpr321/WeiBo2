//
//  WBHomeMenuController.m
//  翻版新浪微博
//
//  Created by mac on 15-2-21.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBHomeMenuController.h"

@interface WBHomeMenuController ()

@end

@implementation WBHomeMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:nil];
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据%ld",indexPath.row];
    return cell;
}

@end
