//
//  WBDropDownMenu.h
//  翻版新浪微博
//
//  Created by mac on 15-2-21.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBDropDownMenu;

typedef NS_ENUM(NSInteger, WBDropDownMenuShowSide) {
    WBDropDownMenuShowAuto,
    WBDropDownMenuShowTop,
    WBDropDownMenuShowLeft,
    WBDropDownMenuShowRight,
    WBDropDownMenuShowDown
};

@protocol WBDropDownMenuDelegate <NSObject>
@optional
- (void)dropDownMenuDidShow:(WBDropDownMenu *)menu;
- (void)dropDownMenuDidDismiss:(WBDropDownMenu *)menu;

@end

@interface WBDropDownMenu : UIView

@property (nonatomic,weak) id<WBDropDownMenuDelegate> delegate;

@property (nonatomic,strong) UIViewController *contentController;

// 如果不进行设置默认的值为 150
@property (nonatomic,assign) CGFloat containerWidth;
// 如果不进行设置默认的值为 150
@property (nonatomic,assign) CGFloat containerHeight;

+ (instancetype)dropDownMenu;

- (void)showToView:(UIView *)view side:(WBDropDownMenuShowSide)side withContentController:(UIViewController *)contentController;

@end
