//
//  NSString+Size.m
//  anbang_ios
//
//  Created by 张艳能 on 2017/11/8.
//  Copyright © 2017年 ch. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

//得到中英文字符串长度
- (NSInteger)convertToNumbers {
        NSInteger strlength = 0;
        char  *p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
        for (NSInteger i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
            if (*p) {
                p++;
                strlength++;
            } else {
                p++;
            }
        }
        return strlength;
}

/**
 *  文字的计算
 1.影响的因素：文字字体，规定尺寸
 *    在计算的过程中，如果规定尺寸比实际的尺寸大，则取真实的尺寸，如果规定的尺寸小于真实尺寸，则返回规定的尺寸
 一般情况只需要考虑宽，高一般用MAXFLOAT
 *  @param size 文字的尺寸
 *  @param font 字体
 *
 *  @return 计算后的文字尺寸
 */
- (CGSize)stringSizeWithMaxSize:(CGSize)size withFont:(UIFont *)font{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}


- (CGSize)stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height {
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    CGSize maxSize = CGSizeMake(width, height);
    attr[NSFontAttributeName] = font;
    return [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
}

- (CGSize)stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)width {
    return [self stringSizeWithFont:font maxWidth:width maxHeight:MAXFLOAT];
}

- (CGSize)stringSizeWithFont:(UIFont *)font {
    return [self stringSizeWithFont:font maxWidth:MAXFLOAT];
}
@end
