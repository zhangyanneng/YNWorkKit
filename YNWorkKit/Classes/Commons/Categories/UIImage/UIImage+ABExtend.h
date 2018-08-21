//
//  UIImage+ABExtend.h
//  anbang_ios
//
//  Created by zyn on 16/11/4.
//  Copyright © 2016年 ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetRepresentation;

@interface UIImage (ABExtend)

/**
    截取当前屏幕

 @return image
 */
+ (UIImage *)makeScreenshots;
+ (UIImage *)clipImage:(UIImage *)bigImage origin:(CGPoint)origin side:(CGFloat)side;

///自动缩放到指定大小
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;
///保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;


//图片文件比特压缩
+ (NSData *)compressImage:(UIImage *)image withSize:(CGFloat)maxFileSize;
/**maxFileScale文件比例*/
+ (NSData *)compressImage:(ALAssetRepresentation *)assetRepresentation withMaxFileScale:(CGFloat)maxFileScale;
//图像尺寸压缩 - 固定宽
+ (UIImage *)drawImage:(UIImage *)image fixedWidth:(CGFloat)fixedWidth;

/**
 *  加载图片
 *
 *  @param schoolName 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/**
 *  修改图片的透明度
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

/**
 *  将一个UIImage 缩放变换到指定Size的UIImage
 */
+(UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
/**
 * 画一张UIImage
 */
+(UIImage *)drawImageWith:(UIColor *)color withSize:(CGSize)size;

//图片加圆角
+ (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;
//剪裁图片
- (UIImage *)clipImageInRect:(CGRect)rect;


//===============================================================================
//
/**
 *  生成一张高斯模糊的图片
 *
 *  @param image 原图
 *  @param blur  模糊程度 (0~1)
 *
 *  @return 高斯模糊图片
 */
+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur;

/**
 *  根据颜色生成一张图片
 *
 *  @param color 颜色
 *  @param size  图片大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  生成圆角的图片
 *
 *  @param originImage 原始图片
 *  @param borderColor 边框原色
 *  @param borderWidth 边框宽度
 *
 *  @return 圆形图片
 */
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;


/**
 将view转换为UIimage

 @param view 需要转换的view
 @return image
 */
+ (UIImage *)imageFromView:(UIView *)view;


//颜色转换为背景图片
+(UIImage *)imageWithColor:(UIColor *)color;

@end
