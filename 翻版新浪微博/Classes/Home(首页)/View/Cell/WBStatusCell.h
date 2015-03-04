//
//  WBStatusCell.h
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatus;

@interface WBStatusCell : UITableViewCell

+ (instancetype)statusCellWithTableView:(UITableView *)tableView;

/** 数据模型 */
@property (nonatomic,strong) WBStatus *status;

/** 获取cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;

/** 该cell的重用标示符 */
+ (NSString *)statusCellIdentifier;

@end
