//
//  NSString+Size.m
//  anbang_ios
//
//  Created by cbsl on 2017/8/24.
//  Copyright © 2017年 ch. All rights reserved.
//

#import "NSString+DrawSize.h"

#import <CoreText/CoreText.h>


@implementation NSString(DrawSize)

- (CGSize)nativeCalculateSizeWithFont:(UIFont *)font
              constrainedToSize:(CGSize)size{
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    rect.size.height = rect.size.height + 4;
    return rect.size;
}




- (CGSize)calculateSizeWithFont:(UIFont*)font {
    return [self calculateSizeWithFont:font
                               padding:UIEdgeInsetsZero
                             lineSpace:0.0
                             lineBreak:NSLineBreakByWordWrapping
                     constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (CGSize)calculateSizeWithFont:(UIFont*)font
              constrainedToSize:(CGSize)size {
    return [self calculateSizeWithFont:font
                               padding:UIEdgeInsetsZero
                             lineSpace:0.0
                             lineBreak:NSLineBreakByWordWrapping
                     constrainedToSize:size];
}

- (CGSize)calculateSizeWithFont:(UIFont*)font
                        padding:(UIEdgeInsets)padding
                      lineSpace:(CGFloat)lineSpace
                      lineBreak:(NSLineBreakMode)lineBreak
              constrainedToSize:(CGSize)size {
    NSInteger maxLength = 0;
    return [self calculateSizeWithFont:font
                               padding:padding
                             lineSpace:lineSpace
                             lineBreak:lineBreak
                          maxLineCount:0
                     constrainedToSize:size
                      validTitleLength:&maxLength];
}

- (CGSize)calculateSizeWithFont:(UIFont*)font
                        padding:(UIEdgeInsets)padding
                      lineSpace:(CGFloat)lineSpace
                      lineBreak:(NSLineBreakMode)lineBreak
                   maxLineCount:(NSInteger)maxLineCount
              constrainedToSize:(CGSize)size
               validTitleLength:(NSInteger*)maxLength {
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)[font fontName], [font pointSize], &transform);
    
    // Initialize a rectangular path.
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(padding.left,
                               padding.right,
                               size.width - (padding.left + padding.right),
                               size.height - (padding.top + padding.bottom));
    CGPathAddRect(path, NULL, bounds);
    
    // Initialize an attributed string.
    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0), (CFStringRef)self);
    CFAttributedStringSetAttribute(attrString,
                                   CFRangeMake(0, [self length]),
                                   kCTFontAttributeName,
                                   fontRef);
    CFRelease(fontRef);
    
    //line break
    CTParagraphStyleSetting lineBreakMode;
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    
    CTParagraphStyleSetting settings[] = {lineBreakMode};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, 1);   //第二个参数为settings的长度
    CFAttributedStringSetAttribute(attrString,
                                   CFRangeMake(0, [self length]),
                                   kCTParagraphStyleAttributeName,
                                   paragraphStyle);
    CFRelease(paragraphStyle);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    CFRelease(attrString);
    
    NSInteger localtion = 0;
    NSInteger length = [self length];
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,CFRangeMake(localtion, length), path, NULL);
    CFRelease(path);
    
    CFArrayRef lines = CTFrameGetLines(frame);
    NSInteger count = CFArrayGetCount(lines);
    if (maxLineCount != 0 && count > maxLineCount) {
        count = maxLineCount;
    }
    
    double width = 0.0;
    double height = 0.0;
    
    CGFloat ascent,descent,leading;
    ascent = descent = leading = 0.0;
    
    for (NSInteger index = 0; index < count; index++) {
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, index);
        
        CGRect tp = CTLineGetBoundsWithOptions(lineRef, kCTLineBoundsExcludeTypographicLeading);
        if (width < tp.size.width - tp.origin.x) {
            width = tp.size.width - tp.origin.x;
        }
        height += tp.size.height - tp.origin.y;
        CFRange range = CTLineGetStringRange(lineRef);
        *maxLength = range.location + range.length;
    }
    
    
    height += (count - 1) * lineSpace;// + count * font.pointSize;
    CFRelease(frame);
    CFRelease(framesetter);
    
    return CGSizeMake(ceil(width) + padding.left + padding.right,
                      ceil(height) + padding.top + padding.bottom);
}
@end
