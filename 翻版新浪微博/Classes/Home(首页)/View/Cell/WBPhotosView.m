//
//  WBPhotosView.m
//  翻版新浪微博
//
//  Created by mac on 15-2-23.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

static CGFloat const kImageViewHW = 60;
static CGFloat const kImageViewMargin = 8;
static NSInteger const kColumnCount = 4;

#import "WBPhotosView.h"
#import "WBImageView.h"
#import <UIView+AutoLayout.h>
#import "WBPhoto.h"

@interface WBPhotosView ()

@property (nonatomic,strong) NSMutableArray *imageViews;

@property (nonatomic,weak) NSLayoutConstraint *bottomConstant;

@end

@implementation WBPhotosView

- (NSMutableArray *)imageViews{
    if ( _imageViews == nil ) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    [self closeImageViews];
    [self inflateImageViewWith:photos];
}

- (void)inflateImageViewWith:(NSArray *)photos{
    WBImageView *item = nil;
    WBPhoto *photo = nil;
    NSInteger column = 0;
    NSInteger row = 0;
    for (NSInteger i = 0; i < photos.count; i++) {
        photo = photos[i];
        if ( self.imageViews.count <= i ) {
            
            item = [[WBImageView alloc] init];
            [self.imageViews addObject:item];
            [self addSubview:item];
            row = i / kColumnCount;
            column = i % kColumnCount;
            
            [self setUpItemPhotoView:item atRow:row column:column];
        }
        item = self.imageViews[i];
        item.photo = photo;
        item.heightConstraint.constant = kImageViewHW;
        if ( i == photos.count - 1 ) { // 更新约束
            [self removeConstraint:self.bottomConstant];
            self.bottomConstant = [self autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:item withOffset:kImageViewMargin];
//            WBLog(@"count = %ld",self.imageViews.count);
        }
    }
}

- (void)setUpItemPhotoView:(WBImageView *)photoView atRow:(NSInteger)row column:(NSInteger)column{
    [self removeConstraint:self.bottomConstant];
    // 固定宽高
    [photoView autoSetDimension:ALDimensionWidth toSize:kImageViewHW];
    NSLayoutConstraint *heightConstant = [photoView autoSetDimension:ALDimensionHeight toSize:kImageViewHW];
    photoView.heightConstraint = heightConstant;
    if ( row == 0) { // 第一行
        // 顶部都对齐父控件
        [photoView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kImageViewMargin];
        if ( column == 0 ) { // 第一行第一个
            [photoView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kImageViewMargin];
        } else {
            // 取出上一个
            WBImageView *preImageView = self.imageViews[column -1];
            [photoView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:preImageView withOffset:kImageViewMargin];
        }
    } else { // 非第一行
        if ( column == 0 ) { // 首个
            [photoView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kImageViewMargin];
            WBImageView *preImageView = self.imageViews[(row - 1 )* kColumnCount];
            [photoView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:preImageView withOffset:kImageViewMargin];
        } else {
            WBImageView *preLeftImageView = self.imageViews[row * kColumnCount + column - 1];
            [photoView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:preLeftImageView withOffset:kImageViewMargin];
            WBImageView *preTopImageView = self.imageViews[(row - 1) * kColumnCount + column];
            [photoView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:preTopImageView withOffset:kImageViewMargin];
        }
    }
}

#pragma mark - 关闭所有 ImageView
- (void)closeImageViews{
    for (WBImageView *item in self.imageViews) {
        item.heightConstraint.constant = 0;
    }
}

@end
