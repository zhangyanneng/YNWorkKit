//
//  UIImage+Resizable.m
//

#import "UIImage+Resizable.h"

@implementation UIImage (Resizable)

/**
 *  下面方法现在已经过时，仍然可以继续使用
 *  return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
 */
+ (UIImage *)resizableWithName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.width * 0.5,image.size.height * 0.5,image.size.width * 0.5,image.size.height * 0.5) resizingMode:UIImageResizingModeTile];
}

@end
