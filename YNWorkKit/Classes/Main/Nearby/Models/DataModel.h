//
//  DataModel.h
//  YNWorkKit
//
//  Created by zyn on 2016/11/17.
//  Copyright © 2016年 张艳能. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface DataModel : BaseModel

/**
    标题
 */
@property (nonatomic, copy) NSString *title;

/**
    控制器
 */
@property (nonatomic, copy) NSString *targetVc;



+ (NSArray *)modelDataSource;

@end
