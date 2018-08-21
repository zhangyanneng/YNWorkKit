//
//  NSDate+ABExtend.h
//  anbang_ios
//
//  Created by 张艳能 on 2017/10/16.
//  Copyright © 2017年 ch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 NSDateFormatter 格式说明：
 G: 公元时代，例如AD公元
 yy:年的后2位
 yyyy:完整年
 MM:月，显示为1-12
 MMM:月，显示为英文月份简写,如 Jan
 MMMM:月，显示为英文月份全称，如 Janualy
 dd:日，2位数表示，如02
 d:日，1-2位显示，如 2
 EEE:简写星期几，如Sun
 EEEE:全写星期几，如Sunday
 aa:上下午，AM/PM
 H:时，24小时制，0-23
 K：时，12小时制，0-11
 m:分，1-2位
 mm:分，2位
 s:秒，1-2位
 ss:秒，2位
 S:毫秒
 
 */

@interface NSDate (ABExtend)

#pragma mark - 时间获取
/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;
/**
 *  获取星期几
 *
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)weekday;

//获取当天的0点时间
- (NSDate *)midnight;

#pragma mark - 格式转换
//时间转字符串
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;

//字符串转换到时间
+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

//时间戳转时间字符串
+ (NSString *)stringWithTimeInterval:(long long)timeInterval format:(NSString *)format;

//时间字符串(yyyy-MM-dd HH:mm:ss)转时间戳
+ (NSTimeInterval)timeIntervalWithString:(NSString *)dateString;

//时间转字符串
- (NSString *)stringWithFormat:(NSString *)format;

#pragma mark - 时间计算
//判断两个时间是否是同一天
- (BOOL)isSameDayWithDate:(NSDate *)date;



@end
