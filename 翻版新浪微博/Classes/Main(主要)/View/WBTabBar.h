//
//  WBTabBar.h
//  翻版新浪微博
//
//  Created by mac on 15-2-21.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBTabBar;

@protocol WBTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBar:(WBTabBar *)tabBar addButtonDidClicked:(UIButton *)button;

@end

@interface WBTabBar : UITabBar

@property (nonatomic,weak) id<WBTabBarDelegate> delegate;

@end
