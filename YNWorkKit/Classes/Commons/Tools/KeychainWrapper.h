
#import <Foundation/Foundation.h>

@interface KeychainWrapper : NSObject

/**
 *  使用默认标识（App Bundle ID）初始化
 *
 *  @return
 */
+ (instancetype)defaultWrapper;
/**
 *  使用标识和组初始化
 *
 *  @param identifier 标识
 *  @param group      组名称
 *
 *  @return
 */
- (instancetype)initWithIdentifier:(NSString *)identifier accessGroup:(NSString *)group;
/**
 *  保存
 *
 *  @param object 对象
 *  @param key    保存Key
 *
 *  @return 保存结果
 */
- (BOOL)setObject:(id)object forKey:(id)key;
/**
 *  查找对象
 *
 *  @param key 查找Key
 *
 *  @return 对象
 */
- (id)objectForKey:(id)key;
/**
 *  删除对象
 *
 *  @param key 删除Key
 *
 *  @return 删除结果
 */
- (BOOL)removeForKey:(id)key;
@end
