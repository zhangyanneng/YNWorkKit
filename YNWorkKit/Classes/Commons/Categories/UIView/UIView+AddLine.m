//
//  UIView+AddLine.m
//  anbang_ios
//
//  Created by 张艳能 on 2018/2/24.
//  Copyright © 2018年 ch. All rights reserved.
//

#import "UIView+AddLine.h"

@implementation UIView (AddLine)

- (void)addPosition:(ADDLINEPOSITION)position {
    [self addPosition:position color:[UIColor lightGrayColor] width:0.5];
}

- (void)addPosition:(ADDLINEPOSITION)position color:(UIColor*)color {
    
    [self addPosition:position color:color width:0.5];
}

- (void)addPosition:(ADDLINEPOSITION)position color:(UIColor*)color width:(CGFloat)width {
    
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = color.CGColor;
    
    switch (position) {
        case ADDLINEPOSITION_LEFT:
        {
            layer.frame = CGRectMake(0, 0, width, self.bounds.size.height);
        }
            break;
        case ADDLINEPOSITION_RIGHT:
        {
             layer.frame = CGRectMake(self.bounds.size.width - width, 0, width, self.bounds.size.height);
        }
            break;
        case ADDLINEPOSITION_TOP:
        {
            layer.frame = CGRectMake(0, 0, self.bounds.size.width, width);
        }
            break;
        case ADDLINEPOSITION_BOTTOM:
        {
             layer.frame = CGRectMake(0, self.bounds.size.height - width, self.bounds.size.width, width);
        }
            break;
            
        default:
             layer.frame = CGRectMake(0, 0, width, self.bounds.size.height);
            break;
    }
    
    [self.layer addSublayer:layer];
}



@end
