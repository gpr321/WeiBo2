//
//  UIImage+Extendsion.m
//  category
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "UIImage+Extendsion.h"

@implementation UIImage (Extendsion)

/**
 *  根据指定区域裁剪图片
 *
 *  @param rect 指定的区域
 *
 *  @return 裁剪好的图片
 */
- (UIImage *)gp_clipImageBy:(CGRect)rect{
    return  [UIImage 	imageWithCGImage:CGImageCreateWithImageInRect(self.CGImage, rect)];
}

/**
 *  加载一张不被渲染的图片
 *
 *  @param name 图片名
 *
 *  @return 原图片
 */
+ (instancetype)gp_imageFromOriginalName:(NSString *)name{
    UIImage *img = [UIImage imageNamed:name];
    // 使用原模式加载图片
    img = [img 	imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
}

/**
 *  创建一个圆环图片
 *
 *  @param name         图片名称
 *  @param boarderWidth 圆环的宽度
 *  @param color        圆环的颜色
 *
 *  @return 所要的图片
 */
+ (instancetype)gp_image:(NSString *)name BoarderWith:(CGFloat)boarderWidth BoardColor:(UIColor *)gp_color{
    UIImage *image = [UIImage imageNamed:name];
    CGRect loopRect = CGRectMake(0, 0, image.size.width + 2 * boarderWidth, image.size.height + 2 * boarderWidth);
    CGRect imgRect = CGRectMake(boarderWidth, boarderWidth, image.size.width , image.size.height);
    // 圆环
    UIGraphicsBeginImageContextWithOptions(loopRect.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:loopRect];
    [[UIColor blueColor] set];
    [path fill];
    // 图片
    UIBezierPath *imgpath = [UIBezierPath bezierPathWithOvalInRect:imgRect];
    [imgpath addClip];
    [imgpath stroke];
    [image drawInRect:imgRect];
    // 获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return img;
    
}

/**
 *  把一个view显示的内容生成图片
 *
 *  @param view
 *
 *  @return 生成的图片
 */
+ (instancetype)gp_imageWithView:(UIView *)view{
    // 创建图片上下文
    UIGraphicsBeginImageContext(view.bounds.size);
    // 获取创建的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 获取控件信息,把信息保存到上下文
    [view.layer renderInContext:ctx];
    // 生成图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return img;
}

/**
 *  把一个view显示的内容生成图片
 *
 *  @param view
 *
 *  @return 生成的图片
 */
+ (instancetype)gp_imageWithView:(UIView *)view Opaque:(BOOL)opaque{
    // 创建图片上下文
    //    UIGraphicsBeginImageContext(view.bounds.size);
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,opaque, 0);
    // 获取创建的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 获取控件信息,把信息保存到上下文
    [view.layer renderInContext:ctx];
    // 生成图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return img;
}

/**
 *  画一个图片水印到当前图片上
 *
 *  @param img   水印图片
 *  @param frame 水印在该图片中的显示位置
 *
 *  @return 处理好的图片
 */
- (instancetype)gp_waterMarkWith:(UIImage *)img inFrameOfCurImage:(CGRect)frame{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 把当前图片渲染到上下文中
    CGRect imgR = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:imgR];
    // 画水印
    [img drawInRect:frame];
    // 获取上下文中的图片
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 返回图片
    return result;
}

/**
 *  画一个图片水印到当前图片上,默认会显示在图片的右下角
 *
 *  @param img 水印图片
 *
 *  @return 处理好的图片
 */
- (instancetype)gp_waterMarkWith:(UIImage *)img{
    CGFloat w = img.size.width;
    CGFloat h = img.size.height;
    CGFloat x = self.size.width - w;
    CGFloat y = self.size.height - h;
    CGRect fame = CGRectMake(x, y, w, h);
    UIImage *result = [self gp_waterMarkWith:img inFrameOfCurImage:fame];
    return result;
    
}

/**
 *  画一个文字水印在当前图片上
 *
 *  @param str      图片上的文字
 *  @param frame    文字的位置
 *  @param attrInfo 文字样式的信息
 *
 *  @return 处理后的图片
 */
- (instancetype)gp_waterMarkWith:(NSString *)str InRect:(CGRect)frame withAttributes:(NSDictionary *)attrInfo{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 把当前图片渲染到上下文
    CGRect imgR = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:imgR];
    // 画水印
    [str drawInRect:frame withAttributes:attrInfo];
    // 获取上下文图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 返回图片
    return img;
}

/**
 *  画一个文字水印在当前图片上(默认会显示在右下角),此方法必须于- (instancetype)gp_waterMarkWith:(NSString *)str InRect:(CGRect)frame withAttributes:(NSDictionary *)attrInfo 一起拷贝
 *
 *
 *  @param str      图片上的文字
 *  @param attrInfo 文字样式的信息
 *
 *  @return 处理后的图片
 */
- (instancetype)gp_waterMarkWith:(NSString *)str withAttributes:(NSDictionary *)attrInfo{
    CGFloat maxW = self.size.width * 0.5;
    CGFloat maxH = self.size.height * 0.5;
    CGRect frame = [str boundingRectWithSize:CGSizeMake(maxW, maxH) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrInfo context:nil];
    CGFloat strX = self.size.width - frame.size.width;
    CGFloat strY = self.size.height - frame.size.height;
    frame.origin.x = strX;
    frame.origin.y = strY;
    return [self gp_waterMarkWith:str InRect:frame withAttributes:attrInfo];
}

@end
