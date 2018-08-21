//
//  NSDictionary+JSON.m
//  IOSDuoduo
//
//  Created by 独嘉 on 14-6-15.
//  Copyright (c) 2014年 dujia. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)
- (NSString*)jsonString
{
    
    NSData* infoJsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString* json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];

//    NSError *error = nil;  //替换掉 回车和空格
//    NSRegularExpression *expression = [[NSRegularExpression alloc] initWithPattern:@"\\r*\\n*" options:NSRegularExpressionCaseInsensitive error:&error];
//    if (error==nil)
//    {
//        json = [expression stringByReplacingMatchesInString:json options:0 range:NSMakeRange(0, [json length]) withTemplate:@""];
//    }
//    //调整换行符
//    json = [json stringByReplacingOccurrencesOfString:@"\\n" withString:@"<br>"];
//    json = [json stringByReplacingOccurrencesOfString:@"\\r" withString:@"<br>"];
//    json = [json stringByReplacingOccurrencesOfString:@"\\t" withString:@"  "];

    return json;
}

+ (NSDictionary*)initWithJsonString:(NSString*)json
{
    NSError *error = nil;


    if (json==nil)
    {
        return nil;
    }
//    //调整换行符
//    json = [json stringByReplacingOccurrencesOfString:@"\\r" withString:@"<br>"];
//    json = [json stringByReplacingOccurrencesOfString:@"\\n" withString:@"<br>"];
//    json = [json stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
//    json = [json stringByReplacingOccurrencesOfString:@"\r" withString:@"<br>"];
//    json = [json stringByReplacingOccurrencesOfString:@"\\t" withString:@"  "];
//    if ([json isKindOfClass:[NSDictionary class]]) {
//        return (NSDictionary*)json;
//    }
    NSData* infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* info = [NSJSONSerialization JSONObjectWithData:infoData options:NSJSONReadingMutableContainers error:&error];

    return info;
}


@end


@implementation NSArray (JSON)

- (NSString*)jsonString
{
    NSData* infoJsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString* json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];
    return json;
}

+ (NSArray*)initWithJsonString:(NSString*)json
{
    NSError *error = nil;
    NSData* infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* info = [NSJSONSerialization JSONObjectWithData:infoData options:NSJSONReadingMutableContainers error:&error];
    
    return info;
}


@end
