//
//  UIView+AddLine.h
//  anbang_ios
//
//  Created by 张艳能 on 2018/2/24.
//  Copyright © 2018年 ch. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ADDLINEPOSITION_LEFT,
    ADDLINEPOSITION_RIGHT,
    ADDLINEPOSITION_TOP,
    ADDLINEPOSITION_BOTTOM,
} ADDLINEPOSITION;


@interface UIView (AddLine)

- (void)addPosition:(ADDLINEPOSITION)position;

- (void)addPosition:(ADDLINEPOSITION)position color:(UIColor*)color;

- (void)addPosition:(ADDLINEPOSITION)position color:(UIColor*)color width:(CGFloat)width;

@end
