//
//  NSString+Path.h
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

/**
 *  获取Document路径
 */
+ (NSString *)documentPath;
/**
 *  获取cache路径
 */
+ (NSString *)cachePath;
/**
 *  获取temp路径
 */
+ (NSString *)tempPatch;

/**
 *  添加Document文件路径
 *
 */
- (NSString *)appendDocumentPath;
/**
 *  添加cache文件路径
 */
- (NSString *)appendCachePath;
/**
 *  添加temp路径
 */
- (NSString *)appendTempPath;
/**
 *  添加图片地址缓存路径
 *
 */
- (NSString *)appendImageCachePath;
/**
 *  添加图片地址Document路径
 *
 */
- (NSString *)appendImageDocumentPath;
/**
 *  添加图片地址temp路径
 *
 */
- (NSString *)appendImageTempPath;



@end
