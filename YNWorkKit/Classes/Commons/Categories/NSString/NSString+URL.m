//
//  NSString+URL.m
//  anbang_ios
//
//  Created by 冯一男 on 16/1/8.
//  Copyright © 2016年 ch. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)
+ (NSString *)httpWithCommunity:(NSString *)community
{
    NSArray *arr = [community componentsSeparatedByString:@"/"];
    
    return [NSString stringWithFormat:@"%@/%@/%@/",arr[0],arr[1],arr[2]];
}
@end
