//
//  NSString+Path.m
//
//  Created by 张艳能

#import "NSString+Path.h"

@implementation NSString (Path)

#pragma mark - 获取沙盒路径
+ (NSString *)documentPath{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
}

+ (NSString *)cachePath{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
}

+ (NSString *)tempPatch{
    return NSTemporaryDirectory();
}

#pragma mark - 字符串拼接沙盒路径
- (NSString *)appendDocumentPath{
    
    return [[NSString documentPath] stringByAppendingPathComponent:self];
}

- (NSString *)appendCachePath{
    
    return [[NSString cachePath] stringByAppendingPathComponent:self];
}

- (NSString *)appendTempPath{
    
    return [[NSString tempPatch] stringByAppendingPathComponent:self];
}

#pragma mark - 图片地址拼接沙盒路径
- (NSString *)appendImageCachePath {
    
    return [self.lastPathComponent appendCachePath];
}

- (NSString *)appendImageDocumentPath {
    
    return [self.lastPathComponent appendDocumentPath];
}

- (NSString *)appendImageTempPath {
    return [self.lastPathComponent appendTempPath];
}

@end
