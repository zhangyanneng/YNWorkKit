//
//  NSObject+Safe.h


#import <Foundation/Foundation.h>


#define NON_NULL_STRING(str) ([str length] ? str : @"")

@interface NSObject (Safe)

- (NSString *)safeStringValue;
- (NSNumber *)safeNumberValue;
- (NSArray *)safeArrayValue;
- (NSDictionary *)safeDictioaryValue;


@end

@interface NSURL (Safe)

+ (NSURL *)safe_URLWithString:(NSString *)URLString;

@end

@interface NSArray (Safe)

- (id)safe_objectAtIndex:(NSInteger)index;

@end


@interface NSMutableArray (Safe)

- (void)safe_addObject:(id)obj;

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)safe_addObjectsFromArray:(NSArray *)array;

- (void)safe_removeObjectAtIndex:(NSUInteger)index;

- (void)safe_removeObjectsInArray:(NSArray *)otherArray;

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end


@interface NSMutableSet (Safe)

- (void)safe_addObject:(id)object;

- (void)safe_addObjectsFromArray:(NSArray *)array;

@end


@interface NSMutableDictionary (Safe)

- (void)safe_setObject:(id)object forKey:(NSString *)key;

- (void)safe_setObjectFromDic:(NSDictionary *)dic;

@end

