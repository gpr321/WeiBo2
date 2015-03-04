//
//  WBImageView.m
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "WBPhoto.h"

@implementation WBImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)setPhoto:(WBPhoto *)photo{
    _photo = photo;
    [self sd_setImageWithURL:photo.url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

@end
