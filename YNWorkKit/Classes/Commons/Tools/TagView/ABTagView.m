//
//  ABTagView.m
//  anbang_ios
//
//  Created by zyn on 2017/2/28.
//  Copyright © 2017年 ch. All rights reserved.
//

#import "ABTagView.h"

@interface ABTagView()

@end

@implementation ABTagView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.padding = UIEdgeInsetsZero;
        self.minimumItemSize = CGSizeZero;
        self.maximumItemSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
        self.itemMargins = UIEdgeInsetsZero;
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self layoutSubviewsWithSize:size shouldLayout:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutSubviewsWithSize:self.bounds.size shouldLayout:YES];
}

- (CGSize)layoutSubviewsWithSize:(CGSize)size shouldLayout:(BOOL)shouldLayout {
    NSArray<UIView *> *visibleItemViews = [self visibleSubviews];
    
    if (visibleItemViews.count == 0) {
        return CGSizeMake(self.padding.left + self.padding.right, self.padding.top + self.padding.bottom);
    }
    CGPoint itemViewOrigin = CGPointZero;
    if (self.tagAlignment == TAG_ALIGNMENT_LEFT) {
        itemViewOrigin = CGPointMake(self.padding.left, self.padding.top);
    } else {
        itemViewOrigin = CGPointMake(size.width - self.padding.right, self.padding.top);
    }
    
    
    CGFloat currentRowMaxY = itemViewOrigin.y;
    
    for (NSInteger i = 0, l = visibleItemViews.count; i < l; i ++) {
        UIView *itemView = visibleItemViews[i];
        
        CGSize itemViewSize = [itemView sizeThatFits:CGSizeMake(self.maximumItemSize.width, self.maximumItemSize.height)];
        itemViewSize.width = fmaxf(self.minimumItemSize.width, itemViewSize.width);
        itemViewSize.height = fmaxf(self.minimumItemSize.height, itemViewSize.height);
        
        //左边
        if (self.tagAlignment == TAG_ALIGNMENT_LEFT) {
            if (itemViewOrigin.x + self.itemMargins.left + itemViewSize.width > size.width - self.padding.right) {
                // 换行，左边第一个 item 是不考虑 itemMargins.left 的
                if (shouldLayout) {
                    itemView.frame = CGRectMake(self.padding.left, currentRowMaxY + self.itemMargins.top, itemViewSize.width, itemViewSize.height);
                }
                
                itemViewOrigin.x = self.padding.left + itemViewSize.width + self.itemMargins.right;
                itemViewOrigin.y = currentRowMaxY;
            } else {
                // 当前行放得下
                if (shouldLayout) {
                    itemView.frame = CGRectMake(itemViewOrigin.x + self.itemMargins.left, itemViewOrigin.y + self.itemMargins.top, itemViewSize.width, itemViewSize.height);
                }
                
                itemViewOrigin.x += self.itemMargins.left + self.itemMargins.right + itemViewSize.width;
            }
        } else if(self.tagAlignment == TAG_ALIGNMENT_RIGHT) {
            //右边
            if (itemViewOrigin.x - self.itemMargins.right - itemViewSize.width < self.padding.left) {
                // 换行，左边第一个 item 是不考虑 itemMargins.left 的
                CGFloat itemX =size.width - self.padding.right - itemViewSize.width - self.itemMargins.right;
                if (shouldLayout) {
                    itemView.frame = CGRectMake(itemX, currentRowMaxY + self.itemMargins.top, itemViewSize.width, itemViewSize.height);
                }
                
                itemViewOrigin.x = itemX;
                itemViewOrigin.y = currentRowMaxY;
            } else {
                // 当前行放得下
                if (shouldLayout) {
                    itemView.frame = CGRectMake(itemViewOrigin.x - itemViewSize.width - self.itemMargins.right, itemViewOrigin.y + self.itemMargins.top, itemViewSize.width, itemViewSize.height);
                }
                
                itemViewOrigin.x -= (self.itemMargins.right + itemViewSize.width);
            }
        }
        
        
        currentRowMaxY = fmaxf(currentRowMaxY, itemViewOrigin.y + self.itemMargins.top + self.itemMargins.bottom + itemViewSize.height);
    }
    
    // 最后一行不需要考虑 itemMarins.bottom，所以这里减掉
    currentRowMaxY -= self.itemMargins.bottom;
    
    CGSize resultSize = CGSizeMake(size.width, currentRowMaxY + self.padding.bottom);
    return resultSize;
}

- (NSArray<UIView *> *)visibleSubviews {
    NSMutableArray<UIView *> *visibleItemViews = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0, l = self.subviews.count; i < l; i++) {
        UIView *itemView = self.subviews[i];
        if (!itemView.hidden) {
            [visibleItemViews addObject:itemView];
        }
    }
    
    return visibleItemViews;
}

@end

