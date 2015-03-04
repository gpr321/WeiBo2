//
//  WBImageView.h
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBPhoto;

@interface WBImageView : UIImageView

/** 用来控制高度的 */
@property (nonatomic,weak) NSLayoutConstraint *heightConstraint;

@property (nonatomic,strong) WBPhoto *photo;

@end
