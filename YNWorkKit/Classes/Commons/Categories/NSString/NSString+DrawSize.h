//
//  NSString+Size.h
//  anbang_ios
//
//  Created by cbsl on 2017/8/24.
//  Copyright © 2017年 ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString(DrawSize)


- (CGSize)nativeCalculateSizeWithFont:(UIFont*)font
constrainedToSize:(CGSize)size;

- (CGSize)calculateSizeWithFont:(UIFont*)font;

- (CGSize)calculateSizeWithFont:(UIFont*)font
              constrainedToSize:(CGSize)size;

- (CGSize)calculateSizeWithFont:(UIFont*)font
                        padding:(UIEdgeInsets)padding
                      lineSpace:(CGFloat)lineSpace
                      lineBreak:(NSLineBreakMode)lineBreak
              constrainedToSize:(CGSize)size;

- (CGSize)calculateSizeWithFont:(UIFont*)font
                        padding:(UIEdgeInsets)padding
                      lineSpace:(CGFloat)lineSpace
                      lineBreak:(NSLineBreakMode)lineBreak
                   maxLineCount:(NSInteger)maxLineCount
              constrainedToSize:(CGSize)size
               validTitleLength:(NSInteger*)maxLength;

@end
