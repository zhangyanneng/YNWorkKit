//
//  UIImage+Resizable.h
//

#import <UIKit/UIKit.h>

@interface UIImage (Resizable)

/**
 *
 
 *  @param imageName 需要拉伸的图片名称
 *
 *  @return 返回拉伸的图片的图片
 */
+ (UIImage *)resizableWithName:(NSString *)imageName;


@end
