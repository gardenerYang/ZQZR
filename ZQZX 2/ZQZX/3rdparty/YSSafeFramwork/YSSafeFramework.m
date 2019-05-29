//
//  YSSafeFramework.m
//  SafeObjectCrash
//
//  Created by yangshuai on 2018/11/27.
//  Copyright © 2018年 danielYang. All rights reserved.
//

#import "YSSafeFramework.h"
#if DEBUG
#define YSSafeLOG(...) YSSafeFrameworkLog(__VA_ARGS__)
#else
#define YSSafeLOG(...)
#endif

void YSSafeFrameworkLog(NSString *fmt, ...) NS_FORMAT_FUNCTION(1, 2);

void YSSafeFrameworkLog(NSString *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    NSString *content = [[NSString alloc] initWithFormat:fmt arguments:ap];
    NSLog(@"\n********************************************************************************reason:-%@\n\n", content);
    va_end(ap);
    
}

@implementation YSSafeFramework


@end


@implementation NSObject (YSSwizzling)

/**
 交换函数指针

 @param selfClass 方法类
 @param originalSelector 原方法
 @param swizzledSelector 交换方法
 */
+ (void)exchangeInstanceMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(selfClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(selfClass, swizzledSelector);
    BOOL didAddMethod = class_addMethod(selfClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(selfClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizzlingMethod:(NSString *)systemMethodString systemClassString:(NSString *)systemClassString toSafeMethodString:(NSString *)safeMethodString targetClassString:(NSString *)targetClassString{
    //获取系统方法IMP
    Method sysMethod = class_getInstanceMethod(NSClassFromString(systemClassString), NSSelectorFromString(systemMethodString));
    //自定义方法的IMP
    Method safeMethod = class_getInstanceMethod(NSClassFromString(targetClassString), NSSelectorFromString(safeMethodString));
    //IMP相互交换，方法的实现也就互相交换了
    method_exchangeImplementations(safeMethod,sysMethod);
}

@end

#pragma mark --------------------------NSArray

@implementation NSArray (YSSafeFramework)
+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //替换 objectAtIndex
        NSString *tmpStr = @"objectAtIndex:";
        NSString *tmpFirstStr = @"safe_ZeroObjectAtIndex:";
        NSString *tmpThreeStr = @"safe_objectAtIndex:";
        NSString *tmpSecondStr = @"safe_singleObjectAtIndex:";
        
        // 替换 objectAtIndexedSubscript
        
        NSString *tmpSubscriptStr = @"objectAtIndexedSubscript:";
        NSString *tmpSecondSubscriptStr = @"safe_objectAtIndexedSubscript:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArray0")
                                     originalSelector:NSSelectorFromString(tmpStr)                                     swizzledSelector:NSSelectorFromString(tmpFirstStr)];
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSSingleObjectArrayI")
                                     originalSelector:NSSelectorFromString(tmpStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondStr)];
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayI")
                                     originalSelector:NSSelectorFromString(tmpStr)                                     swizzledSelector:NSSelectorFromString(tmpThreeStr)];
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayI")
                                     originalSelector:NSSelectorFromString(tmpSubscriptStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondSubscriptStr)];
        
    });
    
    
}
#pragma mark --- implement method

/**
 取出NSArray 第index个 值 对应 __NSArrayI
 
 @param index 索引 index
 @return 返回值
 */
- (id)safe_objectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        YSSafeLOG(@"[%@ %@] index %lu beyond bounds [0 .. %lu]",
                 NSStringFromClass([self class]),
                 NSStringFromSelector(_cmd),
                 (unsigned long)index,
                 MAX((unsigned long)self.count - 1, 0));
        return nil;
    }
    return [self safe_objectAtIndex:index];
}


/**
 取出NSArray 第index个 值 对应 __NSSingleObjectArrayI
 
 @param index 索引 index
 @return 返回值
 */
- (id)safe_singleObjectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        YSSafeLOG(@"[%@ %@] index %lu beyond bounds [0 .. %lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.count - 1, 0));

        return nil;
    }
    return [self safe_singleObjectAtIndex:index];
}

/**
 取出NSArray 第index个 值 对应 __NSArray0
 
 @param index 索引 index
 @return 返回值
 */
- (id)safe_ZeroObjectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        YSSafeLOG(@"[%@ %@] index %lu beyond bounds [0 .. %lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.count - 1, 0));

        return nil;
    }
    return [self safe_ZeroObjectAtIndex:index];
}

/**
 取出NSArray 第index个 值 对应 __NSArrayI
 
 @param idx 索引 idx
 @return 返回值
 */
- (id)safe_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count){
        YSSafeLOG(@"[%@ %@] index %lu beyond bounds [0 .. %lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.count - 1, 0));

        return nil;
    }
    return [self safe_objectAtIndexedSubscript:idx];
}


@end
#pragma mark --------------------------NSMutableArray


@implementation NSMutableArray (YSSafeFramework)
+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //替换 objectAtIndex:
        NSString *tmpGetStr = @"objectAtIndex:";
        NSString *tmpSafeGetStr = @"safeMutable_objectAtIndex:";
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpGetStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeGetStr)];
        
        //替换 removeObjectsInRange:
        NSString *tmpRemoveStr = @"removeObjectsInRange:";
        NSString *tmpSafeRemoveStr = @"safeMutable_removeObjectsInRange:";
        
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpRemoveStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRemoveStr)];
        
        
        //替换 insertObject:atIndex:
        NSString *tmpInsertStr = @"insertObject:atIndex:";
        NSString *tmpSafeInsertStr = @"safeMutable_insertObject:atIndex:";
        
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpInsertStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeInsertStr)];
        
        //替换 removeObject:inRange:
        NSString *tmpRemoveRangeStr = @"removeObject:inRange:";
        NSString *tmpSafeRemoveRangeStr = @"safeMutable_removeObject:inRange:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpRemoveRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRemoveRangeStr)];
        
        
        // 替换 objectAtIndexedSubscript
        
        NSString *tmpSubscriptStr = @"objectAtIndexedSubscript:";
        NSString *tmpSecondSubscriptStr = @"safeMutable_objectAtIndexedSubscript:";
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpSubscriptStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondSubscriptStr)];
    });
}

#pragma mark --- implement method

/**
 取出NSArray 第index个 值
 
 @param index 索引 index
 @return 返回值
 */
- (id)safeMutable_objectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        YSSafeLOG(@"[%@ %@] index %lu beyond bounds [0 .. %lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.count - 1, 0));
        return nil;
    }
    return [self safeMutable_objectAtIndex:index];
}

/**
 NSMutableArray 移除 索引 index 对应的 值
 
 @param range 移除 范围
 */
- (void)safeMutable_removeObjectsInRange:(NSRange)range {
    
    if (range.location > self.count) {
        NSLog(@"*************************************************数组越界");
        return;
    }
    
    if (range.length > self.count) {
        NSLog(@"*************************************************数组越界");
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        NSLog(@"*************************************************数组越界");
        
        return;
    }
    
    return [self safeMutable_removeObjectsInRange:range];
}


/**
 在range范围内， 移除掉anObject
 
 @param anObject 移除的anObject
 @param range 范围
 */
- (void)safeMutable_removeObject:(id)anObject inRange:(NSRange)range {
    if (range.location > self.count) {
        NSLog(@"*************************************************数组越界");
        return;
    }
    
    if (range.length > self.count) {
        NSLog(@"*************************************************数组越界");
        
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        NSLog(@"*************************************************数组越界");
        
        return;
    }
    
    if (!anObject){
        NSLog(@"*************************************************数组为空");
        return;
    }
    
    
    return [self safeMutable_removeObject:anObject inRange:range];
    
}

/**
 NSMutableArray 插入 新值 到 索引index 指定位置
 
 @param anObject 新值
 @param index 索引 index
 */
- (void)safeMutable_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count) {
        NSLog(@"*************************************************数组越界");
        return;
    }
    
    if (!anObject){
        NSLog(@"*************************************************数组越界");
        return;
    }
    
    [self safeMutable_insertObject:anObject atIndex:index];
}


/**
 取出NSArray 第index个 值 对应 __NSArrayI
 
 @param idx 索引 idx
 @return 返回值
 */
- (id)safeMutable_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count){
        return nil;
    }
    return [self safeMutable_objectAtIndexedSubscript:idx];
}


@end
#pragma mark -------------------------- NSDictionary



@implementation NSDictionary (YSSafeFramework)

+ (void)load{
    [self swizzlingMethod:@"initWithObjects:forKeys:count:" systemClassString:@"__NSPlaceholderDictionary" toSafeMethodString:@"initWithObjects_st:forKeys:count:" targetClassString:@"NSDictionary"];
}

-(instancetype)initWithObjects_st:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)count {
    NSUInteger rightCount = 0;
    for (NSUInteger i = 0; i < count; i++) {
        if (!(keys[i] && objects[i])) {
            YSSafeLOG(@"[%@ %@]  nil key. key cannot be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            break;
        }else{
            rightCount++;
        }
    }
    self = [self initWithObjects_st:objects forKeys:keys count:rightCount];
    return self;
}
@end
#pragma mark -------------------------- NSMutableDictionary

@interface NSMutableDictionary (YSSafeFramework)

@end

@implementation NSMutableDictionary (YSSafeFramework)

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 替换 removeObjectForKey:
        NSString *tmpRemoveStr = @"removeObjectForKey:";
        NSString *tmpSafeRemoveStr = @"safeMutable_removeObjectForKey:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSDictionaryM")
                                     originalSelector:NSSelectorFromString(tmpRemoveStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRemoveStr)];
        
        
        
        // 替换 setObject:forKey:
        NSString *tmpSetStr = @"setObject:forKey:";
        NSString *tmpSafeSetRemoveStr = @"safeMutable_setObject:forKey:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSDictionaryM")
                                     originalSelector:NSSelectorFromString(tmpSetStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSetRemoveStr)];
        
    });
    
}
#pragma mark --- implement method

/**
 根据akey 移除 对应的 键值对
 
 @param aKey key
 */
- (void)safeMutable_removeObjectForKey:(id<NSCopying>)aKey {
    if (!aKey) {
        YSSafeLOG(@"[%@ %@] NSMutableDictionary nil key. key cannot be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    [self safeMutable_removeObjectForKey:aKey];
}

/**
 将键值对 添加 到 NSMutableDictionary 内
 
 @param anObject 值
 @param aKey 键
 */
- (void)safeMutable_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject) {
        YSSafeLOG(@"[%@ %@] NSMutableDictionary nil object. object cannot be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    if (!aKey) {
        YSSafeLOG(@"[%@ %@]  NSMutableDictionary nil key. key cannot be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    return [self safeMutable_setObject:anObject forKey:aKey];
}

@end



@implementation NSMutableString (YSSafeFramework)

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 替换  substringFromIndex:
        NSString *tmpSubFromStr = @"substringFromIndex:";
        NSString *tmpSafeSubFromStr = @"safeMutable_substringFromIndex:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubFromStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubFromStr)];
        
        
        // 替换  substringToIndex:
        NSString *tmpSubToStr = @"substringToIndex:";
        NSString *tmpSafeSubToStr = @"safeMutable_substringToIndex:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubToStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubToStr)];
        
        
        // 替换  substringWithRange:
        NSString *tmpSubRangeStr = @"substringWithRange:";
        NSString *tmpSafeSubRangeStr = @"safeMutable_substringWithRange:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubRangeStr)];
        
        
        
        // 替换  rangeOfString:options:range:locale:
        NSString *tmpRangeOfStr = @"rangeOfString:options:range:locale:";
        NSString *tmpSafeRangeOfStr = @"safeMutable_rangeOfString:options:range:locale:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpRangeOfStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRangeOfStr)];
        
        
        // 替换  appendString
        NSString *tmpAppendStr = @"appendString:";
        NSString *tmpSafeAppendStr = @"safeMutable_appendString:";
        
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpAppendStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeAppendStr)];
        
        
    });
    
}
#pragma mark --- implement method
/****************************************  substringFromIndex:  ***********************************/
/**
 从from位置截取字符串 对应 __NSCFString
 
 @param from 截取起始位置
 @return 截取的子字符串
 */
- (NSString *)safeMutable_substringFromIndex:(NSUInteger)from {
    if (from > self.length ) {
        YSSafeLOG(@"[%@ %@] index %lu beyond bounds [0 .. %lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)from,
                  MAX((unsigned long)self.length - 1, 0));
        return nil;
    }
    return [self safeMutable_substringFromIndex:from];
}


/****************************************  substringFromIndex:  ***********************************/
/**
 从开始截取到to位置的字符串  对应  __NSCFString
 
 @param to 截取终点位置
 @return 返回截取的字符串
 */
- (NSString *)safeMutable_substringToIndex:(NSUInteger)to {
    if (to > self.length ) {
        YSSafeLOG(@"[%@ %@] index %lu beyond bounds [0 .. %lu]",
                 NSStringFromClass([self class]),
                 NSStringFromSelector(_cmd),
                 (unsigned long)to,
                 MAX((unsigned long)self.length - 1, 0));
        
        return nil;
    }
    return [self safeMutable_substringToIndex:to];
}



/*********************************** rangeOfString:options:range:locale:  ***************************/
/**
 搜索指定 字符串  对应  __NSCFString
 
 @param searchString 指定 字符串
 @param mask 比较模式
 @param rangeOfReceiverToSearch 搜索 范围
 @param locale 本地化
 @return 返回搜索到的字符串 范围
 */
- (NSRange)safeMutable_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale {
    if (!searchString) {
        searchString = self;
    }
    
    if (rangeOfReceiverToSearch.location > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if (rangeOfReceiverToSearch.length > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if ((rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length) > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    
    return [self safeMutable_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
}



/*********************************** substringWithRange:  ***************************/
/**
 截取指定范围的字符串  对应  __NSCFString
 
 @param range 指定的范围
 @return 返回截取的字符串
 */
- (NSString *)safeMutable_substringWithRange:(NSRange)range {
    if (range.location > self.length) {
        NSLog(@"*************************************************下标越界");
        return nil;
    }
    
    if (range.length > self.length) {
        NSLog(@"*************************************************下标越界");
        return nil;
    }
    
    if ((range.location + range.length) > self.length) {
        NSLog(@"*************************************************下标越界");
        return nil;
    }
    return [self safeMutable_substringWithRange:range];
}


/*********************************** safeMutable_appendString:  ***************************/
/**
 追加字符串 对应  __NSCFString
 
 @param aString 追加的字符串
 */
- (void)safeMutable_appendString:(NSString *)aString {
    if (!aString) {
        NSLog(@"*************************************************字符串为空");
        return;
    }
    return [self safeMutable_appendString:aString];
}
@end
