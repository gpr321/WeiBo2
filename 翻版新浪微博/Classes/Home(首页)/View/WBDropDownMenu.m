//
//  WBDropDownMenu.m
//  翻版新浪微博
//
//  Created by mac on 15-2-21.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#define kDefaultWidthHeight 200
#define kContainerViewPadding 10

#import "WBDropDownMenu.h"
#import "UIView+Frame.h"

@interface WBDropDownMenu ()

@property (nonatomic,assign) UIImageView *containerView;
@property (nonatomic,weak) UIView *contentView;

@end

@implementation WBDropDownMenu

#pragma mark - 初始化方法
+ (instancetype)dropDownMenu{
    return [[WBDropDownMenu alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 泡泡的宽高
- (CGFloat)containerHeight{
    if ( _containerHeight == 0 ) {
        return kDefaultWidthHeight;
    }
    return _containerHeight;
}

- (CGFloat)containerWidth{
    if ( _containerWidth == 0 ) {
        return kDefaultWidthHeight;
    }
    return _containerWidth;
}

#pragma mark - 泡泡容器视图
- (UIImageView *)containerView{
    if ( _containerView == nil ) {
        UIImage *img = [UIImage imageNamed:@"popover_background"];
        UIImageView *containerView = [[UIImageView alloc] initWithImage:img];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        _containerView = containerView;
    }
    return _containerView;
}

- (void)setContentView:(UIView *)contentView{
    [_contentView removeFromSuperview];
    _contentView = contentView;
    [self.containerView addSubview:contentView];
    CGFloat difference = 6;
    CGFloat x = kContainerViewPadding;
    CGFloat y = kContainerViewPadding + difference;
    CGFloat width = _containerView.width - 2 * kContainerViewPadding;
    CGFloat height = _containerView.height - 2 * (kContainerViewPadding +difference);
    contentView.frame = CGRectMake(x, y, width, height);
}

- (void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;
    self.contentView = contentController.view;
}

#pragma mark - 显示 和 消失的方法
- (void)showToView:(UIView *)view side:(WBDropDownMenuShowSide)side withContentController:(UIViewController *)contentController{
    // 把menu添加到顶层的窗口上
    UIWindow *win = [[UIApplication sharedApplication].windows lastObject];
    self.frame = win.bounds;
    [win addSubview:self];
    // 初始化 containerView 的尺寸
    self.containerView.bounds = CGRectMake(0, 0, self.containerWidth, self.containerHeight);
    self.containerView.layer.anchorPoint = CGPointMake(0.5, 0);
    if ( side == WBDropDownMenuShowAuto ) {
        side = WBDropDownMenuShowDown;
    }
    CGPoint viewCenterPoint = [self convertPoint:CGPointMake(view.width * 0.5, view.height * 0.5) fromView:view];
    CGPoint containerCenter = viewCenterPoint;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (side) {
        case WBDropDownMenuShowTop:
            containerCenter.y -= view.height * 0.5;
            transform = CGAffineTransformMakeRotation(M_PI);
            break;
        case WBDropDownMenuShowLeft:
            containerCenter.x -= view.width * 0.5;
            transform = CGAffineTransformMakeRotation(M_PI * 0.5);
            break;
        case WBDropDownMenuShowDown:
            containerCenter.y += view.height * 0.5;
            break;
        case WBDropDownMenuShowRight:
            containerCenter.x += view.width * 0.5;
            transform = CGAffineTransformMakeRotation( - M_PI * 0.5);
            break;
        default:
            break;
    }
    self.containerView.center = containerCenter;
    self.containerView.transform = transform;
    self.contentController = contentController;
    if ( [self.delegate respondsToSelector:@selector(dropDownMenuDidShow:)] ) {
        [self.delegate dropDownMenuDidShow:self];
    }
}

- (void)dismiss{
    [self removeFromSuperview];
}

#pragma mark - 触摸事件监听方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismiss];
    if ( [self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)] ) {
        [self.delegate dropDownMenuDidDismiss:self];
    }
}

@end
