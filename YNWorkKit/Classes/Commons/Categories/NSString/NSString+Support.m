//
//  NSString+Support.m
//  anbang_ios
//
//  Created by 刘宏伟 on 2016/11/30.
//  Copyright © 2016年 ch. All rights reserved.
//

#import "NSString+Support.h"

@implementation NSString (Support)

- (NSString *)concat:(NSString *)subString {
    return [self stringByAppendingString:subString];
}


@end
