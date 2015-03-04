//
//  WBTabBarController.h
//  翻版新浪微博
//
//  Created by mac on 15-2-20.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTabBarController : UITabBarController

- (void)setUpChildControllers;

- (void)addChildController:(UIViewController *)controller withTitile:(NSString *)title image:(NSString *)imgName selectedImage:(NSString *)selectedImgName;

@end
