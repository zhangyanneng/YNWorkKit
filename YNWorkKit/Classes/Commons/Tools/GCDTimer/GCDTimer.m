//
//  GCDTimer.m
//  anbang_ios
//
//  Created by 张艳能 on 2017/10/31.
//  Copyright © 2017年 ch. All rights reserved.
//

#import "GCDTimer.h"


#define kDefualtTimerName @"GCD_defualtTimerName_identifier"


@interface GCDTimer ()

@property (nonatomic,strong) NSCache *timerCache; //时间缓存

@property (nonatomic,strong) NSCache *actionCache; //action缓存

@end

@implementation GCDTimer


#pragma mark - Public Method

+ (instancetype)sharedInstance {
    static GCDTimer *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        instance = [[GCDTimer alloc] init];
        [instance _initial];
    });
    
    return instance;
}

- (void)_initial {
    _timerCache = [[NSCache alloc] init];
    _actionCache = [[NSCache alloc] init];
}



- (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                          actionOption:(GCDTimerAction)option
                                action:(dispatch_block_t)action {
    if (nil == timerName)
        return;
    
    if (nil == queue)
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = [self.timerCache objectForKey:timerName];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerCache setObject:timer forKey:timerName];
    }
    
    /* timer精度为0.01秒 */
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.01 * NSEC_PER_SEC);
    
    __weak typeof(self) weakSelf = self;
    
    switch (option) {
        case AbandonPreviousAction: {
            /* 移除之前的action */
            [weakSelf removeActionCacheForTimer:timerName];
            
            dispatch_source_set_event_handler(timer, ^{
                action();
                
                if (!repeats) {
                    [weakSelf cancelTimerWithName:timerName];
                }
            });
        }
            break;
            
        case MergePreviousAction: {
            /* cache本次的action */
            [self cacheAction:action forTimer:timerName];
            
            dispatch_source_set_event_handler(timer, ^{
                NSMutableArray *actionArray = [self.actionCache objectForKey:timerName];
                [actionArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    dispatch_block_t actionBlock = obj;
                    actionBlock();
                }];
                [weakSelf removeActionCacheForTimer:timerName];
                
                if (!repeats) {
                    [weakSelf cancelTimerWithName:timerName];
                }
            });
        }
            break;
    }
}

- (void)cancelTimerWithName:(NSString *)timerName {
    dispatch_source_t timer =  [self.timerCache objectForKey:timerName];
    
    if (!timer) {
        return;
    }
    
    [self.timerCache removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
    
    [self.actionCache removeObjectForKey:timerName];
}

- (BOOL)existTimer:(NSString *)timerName {
    if ([self.timerCache objectForKey:timerName]) {
        return YES;
    }
    return NO;
}

#pragma mark - Action Cache

- (void)cacheAction:(dispatch_block_t)action forTimer:(NSString *)timerName {
    id actionArray = [self.actionCache objectForKey:timerName];
    
    if (actionArray && [actionArray isKindOfClass:[NSMutableArray class]]) {
        [(NSMutableArray *)actionArray addObject:action];
    } else {
        NSMutableArray *array = [NSMutableArray arrayWithObject:action];
        [self.actionCache setObject:array forKey:timerName];
    }
}

- (void)removeActionCacheForTimer:(NSString *)timerName {
    if (![self.actionCache objectForKey:timerName]) return;
    
    [self.actionCache removeObjectForKey:timerName];
}
@end
