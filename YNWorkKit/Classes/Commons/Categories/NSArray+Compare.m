//
//  NSArray+Compare.m
//  YNWorkKit
//
//  Created by zyn on 2016/11/14.
//  Copyright © 2016年 张艳能. All rights reserved.
//

#import "NSArray+Compare.h"

@implementation NSArray (Compare)

/**
 降序排列
 */
- (void)descSortArray {
    [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 > obj2;
    }];
}

/**
 升序排列
 */
- (void)ascSortArray {
    [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 < obj2;
    }];
}

- (BOOL)isEqualArrayAndOrder:(NSArray *)array {
    
    if (self.count != array.count) {
        return NO;
    }
    for (NSUInteger i = 0; i < self.count; i++) {
        if (![self[i] isEqual:array[i]]) {
            return NO;
        }
    }
    return YES;
}


@end
