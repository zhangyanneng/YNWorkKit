//
//  NSObject+Safe.m


#import "NSObject+Safe.h"

@implementation NSObject (Safe)

- (NSString *)safeStringValue
{
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    }else if ([self respondsToSelector:@selector(stringValue)]) {
        return [self performSelector:@selector(stringValue) withObject:nil];
    }else{
        return [NSString stringWithFormat:@"%@",self];
    }
}
- (NSNumber *)safeNumberValue
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)self;
    }else if ([self isKindOfClass:[NSString class]]){
        NSString *string = (NSString *)self;
        return @([string integerValue]);
    }else{
        return @(0);
    }
}
- (NSArray *)safeArrayValue
{
    if ([self isKindOfClass:[NSArray class]]) {
        return (NSArray *)self;
    }else{
        return nil;
    }
}
- (NSDictionary *)safeDictioaryValue;
{
    if ([self isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)self;
    }else{
        return nil;
    }
}

@end

@implementation NSURL (Safe)

+ (NSURL *)safe_URLWithString:(NSString *)URLString
{
    if ([URLString isKindOfClass:[NSString class]] == NO) {
        return nil;
    }
    
    return [self URLWithString:URLString];
}

@end

@implementation NSArray (Safe)

- (id)safe_objectAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.count) {
        return nil;
    }
    
    return [self objectAtIndex:index];
}

@end


@implementation NSMutableArray (Safe)

- (void)safe_addObject:(id)obj
{
    if (obj != nil) {
        [self addObject:obj];
    }
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    //防止数组越界
    if (index > self.count) {
        index = self.count;
    }
    if (anObject != nil) {
        [self insertObject:anObject atIndex:index];
    }
}

- (void)safe_addObjectsFromArray:(NSArray *)array
{
    if ([array isKindOfClass:[NSArray class]]) {
        [self addObjectsFromArray:array];
    }
}

- (void)safe_removeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

- (void)safe_removeObjectsInArray:(NSArray *)otherArray
{
    if ([otherArray isKindOfClass:[NSArray class]]) {
        [self removeObjectsInArray:otherArray];
    }
}

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (anObject != nil && index < self.count) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
}

@end

@implementation NSMutableSet (Safe)

- (void)safe_addObject:(id)object
{
    if (object != nil) {
        [self addObject:object];
    }
}

- (void)safe_addObjectsFromArray:(NSArray *)array
{
    if ([array isKindOfClass:[NSArray class]]) {
        [self addObjectsFromArray:array];
    }
}

@end


@implementation NSMutableDictionary(Safe)

- (void)safe_setObject:(id)object forKey:(NSString *)key
{
    if (object && key.length > 0) {
        [self setObject:object forKey:key];
    }
}

- (void)safe_setObjectFromDic:(NSDictionary *)dic
{
    if (dic) {
        [self addEntriesFromDictionary:dic];
    }
}

@end
