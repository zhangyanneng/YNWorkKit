//
//  NSString+Size.h
//  anbang_ios
//
//  Created by 张艳能 on 2017/11/8.
//  Copyright © 2017年 ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 
 按照2个英文字符作为一个字，一个中文汉字作为一个字的方式，计算字符串的实际长度
 
 @return 字符串字个数
 */
- (NSInteger)convertToNumbers;
/**
 根据字体，最大宽，高返回文本大小
 
 @param font 字体
 @param width width
 @param height height
 @return size
 */
- (CGSize)stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;
/**
 根据字体，最大宽返回文本大小
 @param font 字体
 @param width 最大宽
 @return size
 */
- (CGSize)stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)width;

/**
 根据字体返回文本的大小
 
 @param size 最大尺寸
 @param font 字体
 @return size
 */
- (CGSize)stringSizeWithMaxSize:(CGSize)size withFont:(UIFont *)font;

/**
 根据字体返回文本的大小

 @param font 字体
 @return size
 */
- (CGSize)stringSizeWithFont:(UIFont *)font;


@end
