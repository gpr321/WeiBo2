//
//  UIBarButtonItem+Button.h
//  大众点评
//
//  Created by mac on 15-2-4.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Button)

/**
 *  创建一个 UIBarButtonItem 里面放了一个按钮,可以监听点击时间
 *
 *  @param imageName           正常显示的图片名字
 *  @param hightLightImageName 高亮状态的图片名字
 *  @param target              监听事件的对象
 *  @param selector            响应事件的方法
 */
+ (instancetype)gp_barButtonItemWithImage:(NSString *)imageName hightLightImage:(NSString *)hightLightImageName target:(id)target action:(SEL)selector;

@end
