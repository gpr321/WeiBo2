//
//  WBNavigationController.m
//  翻版新浪微博
//
//  Created by mac on 15-2-20.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBNavigationController.h"
#import "UIBarButtonItem+Button.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController

+ (void)initialize{
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    // 适配iOS7
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    NSDictionary *norAttribute = @{
            UITextAttributeFont : [UIFont systemFontOfSize:14],
            UITextAttributeTextColor : GPRGB(230, 130, 0)
            };
    [barButtonItem setTitleTextAttributes:norAttribute forState:UIControlStateNormal];
    
    NSDictionary *disableAttribute = @{
                                   UITextAttributeFont : [UIFont systemFontOfSize:14],
                                   UITextAttributeTextColor : [UIColor lightGrayColor]
                                   };
#pragma clang diagnostic pop
    [barButtonItem setTitleTextAttributes:disableAttribute forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) { // 判断是否根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem *backButtonItem = [UIBarButtonItem gp_barButtonItemWithImage:@"navigationbar_back" hightLightImage:@"navigationbar_back_highlighted" target:self action:@selector(backBarItemDidClicked)];
        viewController.navigationItem.leftBarButtonItem = backButtonItem;
        
        UIBarButtonItem *moreButtonItem = [UIBarButtonItem gp_barButtonItemWithImage:@"navigationbar_more" hightLightImage:@"navigationbar_more_highlighted" target:self action:@selector(moreBarItemDidClicked)];
        viewController.navigationItem.rightBarButtonItem = moreButtonItem;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UIBarButtonItem点击监听
- (void)backBarItemDidClicked{
    [self popViewControllerAnimated:YES];
}

- (void)moreBarItemDidClicked{
   // 跳转到根控制器
    [self popToRootViewControllerAnimated:YES];
}

@end
