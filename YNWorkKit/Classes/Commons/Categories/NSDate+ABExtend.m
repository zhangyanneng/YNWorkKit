
//
//  NSDate+ABExtend.m
//  anbang_ios
//
//  Created by 张艳能 on 2017/10/16.
//  Copyright © 2017年 ch. All rights reserved.
//

#import "NSDate+ABExtend.h"

@implementation NSDate (ABExtend)


- (NSUInteger)day {
    //ios(8.0)以上支持
    return [[[NSCalendar currentCalendar] components:(NSCalendarUnitDay) fromDate:self] day];
}

- (NSUInteger)month {
    return [[[NSCalendar currentCalendar] components:(NSCalendarUnitMonth) fromDate:self] month];
}

- (NSUInteger)year {
    return [[[NSCalendar currentCalendar] components:(NSCalendarUnitYear) fromDate:self] year];
}

- (NSUInteger)hour {
    return [[[NSCalendar currentCalendar] components:(NSCalendarUnitHour) fromDate:self] hour];
}

- (NSUInteger)minute {
    return [[[NSCalendar currentCalendar] components:(NSCalendarUnitMinute) fromDate:self] minute];
}

- (NSUInteger)second {
    return [[[NSCalendar currentCalendar] components:(NSCalendarUnitSecond) fromDate:self] second];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:(NSCalendarUnitWeekday) fromDate:self] weekday];
}

- (NSDate *)midnight {
    return [NSDate dateWithString:[NSDate stringWithDate:self format:@"yyyy-MM-dd"] format:@"yyyy-MM-dd"];
}


//时间转字符串
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

//字符串转换到时间
+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:dateString];
}

//时间戳转时间字符串
+ (NSString *)stringWithTimeInterval:(long long)timeInterval format:(NSString *)format {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [self stringWithDate:date format:format];
}

//时间字符串(yyyy-MM-dd HH:mm:ss)转时间戳
+ (NSTimeInterval)timeIntervalWithString:(NSString *)dateString {
    return [[self dateWithString:dateString format:@"yyyy-MM-dd HH:mm:ss"] timeIntervalSince1970];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
}

//判断两个时间是否是同一天
- (BOOL)isSameDayWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *comp2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:date];
    return ([comp1 year] == [comp2 year]
            && [comp1 month] == [comp2 month]
            && [comp1 day] == [comp2 day]);
}


@end
