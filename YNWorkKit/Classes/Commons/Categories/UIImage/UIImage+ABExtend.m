//
//  UIImage+ABExtend.m
//  anbang_ios
//
//  Created by zyn on 16/11/4.
//  Copyright © 2016年 ch. All rights reserved.
//

#import "UIImage+ABExtend.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Accelerate/Accelerate.h>

@implementation UIImage (ABExtend)


//截屏操作
+ (UIImage *)makeScreenshots {
    @autoreleasepool {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        //设为0后，系统就会自动设置正确的比例
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0.0);
        [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
}

+ (UIImage *)clipImage:(UIImage *)bigImage origin:(CGPoint)origin side:(CGFloat)side
{
    @autoreleasepool {
        //定义截图区域
        CGRect subImageRect = CGRectMake(origin.x, origin.y, side, side);
        //大图Ref
        CGImageRef imageRef = bigImage.CGImage;
        //返回小图的Ref
        CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
        
        CGSize size;
        size.width = side;
        size.height = side;
        //1.开启图形上下文 - 参数: 画布尺寸
        UIGraphicsBeginImageContext(size);
        //2.获取当前上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        //3.绘制图片 - 参数: 当前上下文, 小图选定区域, 小图Ref
        CGContextDrawImage(context, subImageRect, subImageRef);
        //4.生成图片
        UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
        //5.关闭上下文
        UIGraphicsEndImageContext();
        
        return smallImage;
    }
}

+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    if (nil == image) {
        
        newimage = nil;
        
    } else {
        
        UIGraphicsBeginImageContext(asize);
        
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}

+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    if (nil == image) {
        
        newimage = nil;
        
    }
    
    else{
        
        CGSize oldsize = image.size;
        
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            
            rect.size.height = asize.height;
            
            rect.origin.x = (asize.width - rect.size.width)/2;
            
            rect.origin.y = 0;
            
        }
        
        else{
            
            rect.size.width = asize.width;
            
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            rect.origin.x = 0;
            
            rect.origin.y = (asize.height - rect.size.height)/2;
            
        }
        
        UIGraphicsBeginImageContext(asize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}


//文件比特压缩
+ (NSData *)compressImage:(UIImage *)image withSize:(CGFloat)maxFileSize
{
    @autoreleasepool {
        NSData *photoData = UIImageJPEGRepresentation(image, 0.5);
        CGFloat compression = 0.9f;
        CGFloat maxCompression = 0.1f;
        //如果图片文件还不够小, 继续降比压缩
        while ([photoData length] > maxFileSize && compression > maxCompression)
        {
            compression -= 0.1;
            photoData = UIImageJPEGRepresentation(image, compression);
        }
        return photoData;
    }
}

+ (NSData *)compressImage:(ALAssetRepresentation *)assetRepresentation withMaxFileScale:(CGFloat)maxFileScale
{
    @autoreleasepool {
        UIImage *image = nil;
        NSDictionary *dic = assetRepresentation.metadata;
        long long pixelWidth = [[dic objectForKey:@"PixelWidth"] longLongValue];
        long long pixelHeight = [[dic objectForKey:@"PixelHeight"] longLongValue];
        long long maxCompressStandard = 1048576;//1024*1024
        long long compressReferenceSize = 409600;//压缩后最大的值：1024*400 = 409600、1024*500 ＝ 512000、1024*450 ＝ 461250
        if( pixelHeight / pixelWidth >= 2.0){//当长图处理；MAX(pixelHeight, pixelWidth) / MIN(pixelWidth, pixelHeight) > 2.0
            maxCompressStandard = maxCompressStandard*2;
            compressReferenceSize = 460800;
        }
        if( assetRepresentation.size > maxCompressStandard){ //大于『某』M，则此时读取“全屏图”, 几百k, 比读原图省时.
            image = [UIImage imageWithCGImage:assetRepresentation.fullScreenImage];//默认使用全屏图
            image = [UIImage drawImage:image fixedWidth:414*3];
        }else{//小于『某』M, 则直接读原图，然后进行压缩
            image = [UIImage imageWithCGImage:assetRepresentation.fullResolutionImage];
            ALAssetOrientation ori = assetRepresentation.orientation;
            UIImageOrientation orientation = (UIImageOrientation)ori;
            image = [UIImage image:image rotation:orientation]; //按真正的方向进行像素重排
            image = [UIImage drawImage:image fixedWidth:414*2]; //这两个函数中的上下文, 配置不同, 无法共用.推入栈里, 更占内存.
        }
        
        NSData *photoData = UIImageJPEGRepresentation(image, 1.0);
        CGFloat compression = 0.95f;
        CGFloat minCompression = 0.1f;/**最小的压缩质量*/
        long long maxFileSize = photoData.length;/**压缩的最大*/
        //DLog(@"尺寸压缩后图片的大小-->%lukb",(unsigned long)photoData.length/1024);
        if((maxFileSize*maxFileScale)  > compressReferenceSize)  //如果压缩后大于compressReferenceSize，则压缩，否则不压缩
        {
            maxFileSize = maxFileSize * maxFileScale;
        }
        maxFileSize = ((maxFileSize >= compressReferenceSize)?compressReferenceSize:maxFileSize);//最大不能超过compressReferenceSize
        //DLog(@"能上传的图片最大为-->%lukb",(unsigned long)maxFileSize/1024);
        //如果图片文件还不够小, 继续降比压缩
        while ([photoData length] > maxFileSize && compression > minCompression)
        {
            compression -= 0.05;
            photoData = UIImageJPEGRepresentation(image, compression);
        }
        //DLog(@"文件压缩后图片的大小（最终上传）-->%lukb",(unsigned long)photoData.length/1024);
        return photoData;
    }
}

//图像尺寸压缩 - 固定宽
+ (UIImage *)drawImage:(UIImage *)image fixedWidth:(CGFloat)fixedWidth
{
    @autoreleasepool {
        //计算新尺寸
        CGFloat scale = image.size.width / fixedWidth;
        if(scale > 1.0){/**比例大于1.0，即图片的宽大于要压缩到的宽度*/
            CGFloat compressHeight = image.size.height / scale;
            CGSize newSize = CGSizeMake(fixedWidth, compressHeight);
            //创建新尺寸绘图上下文
            UIGraphicsBeginImageContext(newSize);
            //绘制图片
            [image drawInRect:(CGRect){CGPointZero, newSize}];
            //提取新绘制图片
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            //关闭上下文
            UIGraphicsEndImageContext();
            
            //返回新图片
            return newImage;
        }
        else/*图片的宽小于要压缩到的宽度，返回原图*/
        {
            return image;
        }
    }
}

+ (UIImage *)imageWithName:(NSString *)name
{
    return [UIImage imageNamed:name];
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}


+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

+(UIImage *)drawImageWith:(UIColor *)color withSize:(CGSize)size
{
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
        [color set];
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

// CTM变换重排像素
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    @autoreleasepool {
        //开始图像上下文
        UIGraphicsBeginImageContext(rect.size);
        
        //做CTM变换
        CGContextRef context = UIGraphicsGetCurrentContext(); //获取当前上下文(img, pdf等上下文)
        CGContextTranslateCTM(context, 0.0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextRotateCTM(context, rotate);
        CGContextTranslateCTM(context, translateX, translateY);
        //缩放
        CGContextScaleCTM(context, scaleX, scaleY);
        
        //绘制
        CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
        //提取新图
        UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
        
        //结束图像上下文
        UIGraphicsEndImageContext();
        
        return newPic;
    }
}


+(UIImage *)imageWithColor:(UIColor *)color{

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - 画圆角图片
+ (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius
{
    @autoreleasepool {
        int w = size.width;
        int h = size.height;
        
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGContextRef contextRef = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
        CGRect rect = CGRectMake(0, 0, w, h);
        
        //创建一个圆角区域的上下文
        CGContextBeginPath(contextRef);
        addRoundedRectToPath(contextRef, rect, radius, radius);
        CGContextClosePath(contextRef);
        CGContextClip(contextRef);
        //在该上下文中画图片
        CGContextDrawImage(contextRef, CGRectMake(0, 0, w, h), image.CGImage);
        //部分像素被mask掉的图片
        CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
        //新图
        UIImage *img = [UIImage imageWithCGImage:imageMasked];
        
        CGContextRelease(contextRef);
        CGColorSpaceRelease(colorSpaceRef);
        CGImageRelease(imageMasked);
        return img;
    }
}


//私有函数
static void
addRoundedRectToPath(CGContextRef contextRef, CGRect rect, float widthOfRadius, float heightOfRadius)
{
    float fw, fh;
    if (widthOfRadius == 0 || heightOfRadius == 0)
    {
        CGContextAddRect(contextRef, rect);
        return;
    }
    
    CGContextSaveGState(contextRef);
    CGContextTranslateCTM(contextRef, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(contextRef, widthOfRadius, heightOfRadius);
    fw = CGRectGetWidth(rect) / widthOfRadius;
    fh = CGRectGetHeight(rect) / heightOfRadius;
    
    CGContextMoveToPoint(contextRef, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(contextRef, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(contextRef, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(contextRef, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(contextRef, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(contextRef);
    CGContextRestoreGState(contextRef);
}

//剪裁图片
- (UIImage *)clipImageInRect:(CGRect)rect
{
//    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
//    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    // 设置裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    [path addClip];
    // 绘制图片
    [self drawInRect:rect];
    // 获取当前图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();

    return image;
}


//===============================================================================

+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur;
{
    // 模糊度越界
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (color) {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
    return nil;
}

+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    //设置边框宽度
    CGFloat imageWH = originImage.size.width;
    
    //计算外圆的尺寸
    CGFloat ovalWH = imageWH + 2 * borderWidth;
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, 0);
    
    //画一个大的圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [borderColor set];
    
    [path fill];
    
    //设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, imageWH, imageWH)];
    [clipPath addClip];
    
    //绘制图片
    [originImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    
    //从上下文中获取图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)imageFromView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, view.layer.contentsScale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
