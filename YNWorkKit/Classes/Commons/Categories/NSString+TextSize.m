//
//  NSString+TextSize.m

#import "NSString+TextSize.h"

@implementation NSString (TextSize)
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
- (CGSize) sizeWithMaxSize:(CGSize)size withFont:(UIFont *)font{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}
@end
