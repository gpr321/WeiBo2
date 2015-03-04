//
//  WBTabBarController.m
//  翻版新浪微博
//
//  Created by mac on 15-2-20.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBTabBarController.h"
#import "WBTabBarController.h"
#import "WBDiscoverController.h"
#import "WBHomeController.h"
#import "WBMeController.h"
#import "WBMessageController.h"
#import "WBNavigationController.h"
#import "UIImage+Extendsion.h"
#import "WBTabBar.h"

@interface WBTabBarController ()<WBTabBarDelegate>


@end

@implementation WBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    WBTabBar *tabBar = [[WBTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    [self setUpChildControllers];
}

- (void)setUpChildControllers{
    WBHomeController *homeController = [[WBHomeController alloc] init];
    [self addChildController:homeController withTitile:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    WBMessageController *messageController = [[WBMessageController alloc] init];
    [self addChildController:messageController withTitile:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    WBDiscoverController *discoverController = [[WBDiscoverController alloc] init];
    [self addChildController:discoverController withTitile:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
   
    WBMeController *meController = [[WBMeController alloc] init];
    [self addChildController:meController withTitile:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}

- (void)addChildController:(UIViewController *)controller withTitile:(NSString *)title image:(NSString *)imgName selectedImage:(NSString *)selectedImgName{
    WBNavigationController *wbNaVC = [[WBNavigationController alloc]  initWithRootViewController:controller];
    // 图片
    controller.tabBarItem.image = [UIImage gp_imageFromOriginalName:imgName];
    controller.title = title;
    controller.tabBarItem.selectedImage = [UIImage gp_imageFromOriginalName:selectedImgName];

    // 文字 适配iOS7
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    NSDictionary *normalTextAttributes = @{UITextAttributeTextColor : GPRGB(123, 123, 123)};
    [controller.tabBarItem setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
    NSDictionary *selectedTextAttributes = @{UITextAttributeTextColor : GPRGB(230, 130, 0)};
#pragma clang diagnostic pop
    [controller.tabBarItem setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    [self addChildViewController:wbNaVC];
}

#pragma mark - WBTabBarDelegate
- (void)tabBar:(WBTabBar *)tabBar addButtonDidClicked:(UIButton *)button{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
