//
//  GCDTimer.h
//  anbang_ios
//
//  Created by 张艳能 on 2017/10/31.
//  Copyright © 2017年 ch. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    AbandonPreviousAction, //移除上一次定时任务
    MergePreviousAction //合并上一次定时任务
} GCDTimerAction;

@interface GCDTimer : NSObject


+ (instancetype)sharedInstance;

/**
 
 @param timerName 名称
 @param interval 时间
 @param queue 队列
 @param repeats 是否重复
 @param option 类型
 @param action 事件
 */
- (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                          actionOption:(GCDTimerAction)option
                                action:(dispatch_block_t)action;
/**
 撤销某个timer。
 
 @param timerName timer的名称，作为唯一标识。
 */
- (void)cancelTimerWithName:(NSString *)timerName;


/**
 *  是否存在某个名称标识的timer
 */
- (BOOL)existTimer:(NSString *)timerName;
@end
