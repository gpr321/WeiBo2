//
//  UIBarButtonItem+Button.m
//  大众点评
//
//  Created by mac on 15-2-4.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "UIBarButtonItem+Button.h"

@implementation UIBarButtonItem (Button)

+ (instancetype)gp_barButtonItemWithImage:(NSString *)imageName hightLightImage:(NSString *)hightLightImageName target:(id)target action:(SEL)selector{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hightLightImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.frame = (CGRect){CGPointZero,button.currentImage.size};
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
