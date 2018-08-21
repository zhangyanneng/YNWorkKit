//
//  NSObject+ModelToDictionary.h
//  anbang_ios
//
//  Created by 张艳能 on 2017/10/17.
//  Copyright © 2017年 ch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ModelToDictionary)

/**
 模型转字典
 @return 字典
 */
- (NSDictionary *_Nullable)dictionaryFromModel;

/**
 模型转json字符串
 @return json字符串
 */
- (NSString *_Nullable)jsonStringFromModel;

/**
 带model的数组或字典转字典

 @param object 带model的数组或字典转
 @return 字典
 */
- (id _Nullable )idFromObject:(nonnull id)object;


@end
