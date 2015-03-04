//
//  WBPhoto.m
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBPhoto.h"

@implementation WBPhoto

- (void)setThumbnail_pic:(NSString *)thumbnail_pic{
    _thumbnail_pic = thumbnail_pic;
    self.url = [NSURL URLWithString:thumbnail_pic];
}

@end
