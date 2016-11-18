//
//  NSArray+Compare.h
//  YNWorkKit
//
//  Created by zyn on 2016/11/14.
//  Copyright © 2016年 张艳能. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Compare)

/**
    降序排列
 */
- (void)descSortArray;

/**
    升序排列
 */
- (void)ascSortArray;


/**
    比较两个数组，顺序和元素都是相同的

 @param array array
 @return return value
 */
- (BOOL)isEqualArrayAndOrder:(NSArray *)array;

@end
