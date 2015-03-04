//
//  UIImage+Extendsion.h
//  category
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extendsion)

/**
 *  根据指定区域裁剪图片
 *
 *  @param rect 指定的区域
 *
 *  @return 裁剪好的图片
 */
- (UIImage *)gp_clipImageBy:(CGRect)rect;

/**
 *  加载一张不被渲染的图片
 *
 *  @param name 图片名
 *
 *  @return 原图片
 */
+ (instancetype)gp_imageFromOriginalName:(NSString *)name;

/**
 *  创建一个圆环图片
 *
 *  @param name         图片名称
 *  @param boarderWidth 圆环的宽度
 *  @param color        圆环的颜色
 *
 *  @return 所要的图片
 */
+ (instancetype)gp_image:(NSString *)name BoarderWith:(CGFloat)boarderWidth BoardColor:(UIColor *)gp_color;

/**
 *  把一个view显示的内容生成图片
 *
 *  @param view
 *
 *  @return 生成的图片
 */
+ (instancetype)gp_imageWithView:(UIView *)view;

/**
 *  把一个view显示的内容生成图片
 *
 *  @param view
 *
 *  @return 生成的图片
 */
+ (instancetype)gp_imageWithView:(UIView *)view Opaque:(BOOL)opaque;

/**
 *  画一个图片水印到当前图片上
 *
 *  @param img   水印图片
 *  @param frame 水印在该图片中的显示位置
 *
 *  @return 处理好的图片
 */
- (instancetype)gp_waterMarkWith:(UIImage *)gp_img inFrameOfCurImage:(CGRect)frame;

/**
 *  画一个图片水印到当前图片上,默认会显示在图片的右下角
 *
 *  @param img 水印图片
 *
 *  @return 处理好的图片
 */
- (instancetype)gp_waterMarkWith:(UIImage *)gp_img;

/**
 *  画一个文字水印在当前图片上
 *
 *  @param str      图片上的文字
 *  @param frame    文字的位置
 *  @param attrInfo 文字样式的信息
 *
 *  @return 处理后的图片
 */
- (instancetype)gp_waterMarkWith:(NSString *)str InRect:(CGRect)frame withAttributes:(NSDictionary *)attrInfo;

/**
 *  画一个文字水印在当前图片上(默认会显示在右下角),此方法必须于- (instancetype)gp_waterMarkWith:(NSString *)str InRect:(CGRect)frame withAttributes:(NSDictionary *)attrInfo 一起拷贝
 *
 *
 *  @param str      图片上的文字
 *  @param attrInfo 文字样式的信息
 *
 *  @return 处理后的图片
 */
- (instancetype)gp_waterMarkWith:(NSString *)str withAttributes:(NSDictionary *)attrInfo;

@end
