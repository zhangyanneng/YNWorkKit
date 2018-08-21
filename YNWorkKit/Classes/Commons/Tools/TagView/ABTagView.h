//
//  ABTagView.h
//  anbang_ios
//
//  Created by zyn on 2017/2/28.
//  Copyright © 2017年 ch. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TAG_ALIGNMENT_LEFT,
    TAG_ALIGNMENT_RIGHT
} ABTagAlignment;

@interface ABTagView : UIView

/**
 *  tagView内部的内容间距，默认为 UIEdgeInsetsZero
 */
@property(nonatomic, assign) UIEdgeInsets padding;

/**
 *  item 的最小宽高，默认为 CGSizeZero，也即不限制。
 */
@property(nonatomic, assign) IBInspectable CGSize minimumItemSize;

/**
 *  item 的最大宽高，默认为 CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)，也即不限制
 */
@property(nonatomic, assign) IBInspectable CGSize maximumItemSize;

/**
 *  item 之间的间距，默认为 UIEdgeInsetsZero。
 *
 *  @warning 上、下、左、右四个边缘的 item 布局时不会考虑。
 */
@property(nonatomic, assign) UIEdgeInsets itemMargins;

/**
 对其方式，默认左对齐
 */
@property (nonatomic, assign) ABTagAlignment tagAlignment;

@end
