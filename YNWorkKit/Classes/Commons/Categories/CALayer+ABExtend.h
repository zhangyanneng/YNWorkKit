//
//  CALayer+ABExtend.h
//  anbang_ios
//
//  Created by 张艳能 on 2017/5/3.
//  Copyright © 2017年 ch. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (ABExtend)

@property (nonatomic) CGFloat x;        ///frame.origin.x.
@property (nonatomic) CGFloat y;         ///frame.origin.y
@property (nonatomic) CGFloat left;        ///frame.origin.x.
@property (nonatomic) CGFloat top;         ///frame.origin.y
@property (nonatomic) CGFloat right;       ///frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///frame.size.width.
@property (nonatomic) CGFloat height;      ///frame.size.height.
@property (nonatomic) CGPoint center;      ///center.
@property (nonatomic) CGFloat centerX;     ///center.x
@property (nonatomic) CGFloat centerY;     ///center.y
@property (nonatomic) CGPoint origin;      ///frame.origin.
@property (nonatomic, getter=frameSize, setter=setFrameSize:) CGSize  size; ///frame.size.

@property (nonatomic) CGFloat transformScale;        ///key path "tranform.scale"

@end
