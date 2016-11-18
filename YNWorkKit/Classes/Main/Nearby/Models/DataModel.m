//
//  DataModel.m
//  YNWorkKit
//
//  Created by zyn on 2016/11/17.
//  Copyright © 2016年 张艳能. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

+ (NSArray *)modelDataSource {
    
    NSMutableArray *arrM = [NSMutableArray array];
    NSArray *array = @[
                       @{
                           @"title" : @"Pop动画",
                           @"targetVc" : @"PopViewController"
                        },
                        @{
                           @"title" : @"Pop动画",
                           @"targetVc" : @"PopViewController"
                        }
                       ];
    for (NSDictionary *dict in array) {
        DataModel *model = [[DataModel alloc] initWithDictionary:dict];
        [arrM addObject:model];
    }
    
    return [arrM copy];
}

@end
