//
//  UIView+ABExtend.h
//  anbang_ios
//
//  Created by zyn on 16/11/10.
//  Copyright © 2016年 ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ABExtend)

@property (nonatomic, assign) CGFloat x;           ///frame.origin.x
@property (nonatomic, assign) CGFloat y;           ///frame.origin.x.

@property (nonatomic, assign) CGFloat left;        ///frame.origin.x.
@property (nonatomic, assign) CGFloat top;         ///frame.origin.y
@property (nonatomic, assign) CGFloat right;       ///frame.origin.x + frame.size.width
@property (nonatomic, assign) CGFloat bottom;      ///frame.origin.y + frame.size.height

@property (nonatomic, assign) CGFloat width;       ///frame.size.width.
@property (nonatomic, assign) CGFloat height;      ///frame.size.height.

@property (nonatomic, assign) CGFloat centerX;     ///center.x
@property (nonatomic, assign) CGFloat centerY;     ///center.y

@property (nonatomic, assign) CGPoint origin;      ///frame.origin.
@property (nonatomic, assign) CGSize  size;        ///frame.size.


/**
 截屏

 @return image
 */
- (UIImage *)snapshotImage;

/**
 Create a snapshot image of the complete view hierarchy.
 @param afterUpdates afterUpdates
 @return image
 */
- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
将当前坐标系上的点转换到目标的坐标系上
 @param 当前view的坐标点
 @param 目标view
 @return 转换的坐标
 */
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view;

/**
 将点从目标系中装换到当前view的坐标系上

 @param point 目标上的点
 @param view 目标view
 @return 当前view上转换的坐标点
 */
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view;

/**
 将当前坐标系上的rect转换到目标的坐标系上

 @param rect rect description
 @param view view description
 @return return value description
 */
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view;

/**
 将rect从目标系中装换到当前view的坐标系上

 @param rect rect description
 @param view view description
 @return return value description
 */
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view;


//给UIView画圆角
- (void)drawCornerWithCorners:(UIRectCorner)corners withCornerRadii:(CGSize)cornerRadii;
@end
