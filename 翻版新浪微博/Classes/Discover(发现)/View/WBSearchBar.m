//
//  WBSearchBar.m
//  翻版新浪微博
//
//  Created by mac on 15-2-21.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "WBSearchBar.h"
#import "UIView+Frame.h"

@interface WBSearchBar ()

@property (nonatomic,weak) UIImageView *searchIcon;

@end

@implementation WBSearchBar

+ (instancetype)searchBar{
    return [[self alloc]init];
}


- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ) {
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.placeholder = @"请输入搜索条件";
        self.font = [UIFont systemFontOfSize:15];
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.searchIcon = searchIcon;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
