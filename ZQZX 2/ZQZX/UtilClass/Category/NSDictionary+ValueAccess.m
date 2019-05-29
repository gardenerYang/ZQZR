//
//  NSDictionary+ValueAccess.m
//  ZhongRongJinFu
//
//  Created by Yosef Lin on 9/9/15.
//  Copyright (c) 2015 Yosef Lin. All rights reserved.
//

#import "NSDictionary+ValueAccess.h"

@implementation NSDictionary(ValueAccess)

-(BOOL)booleanValueForKey:(NSObject*)key
{
    return [self objectForKey:key] != nil ? [[self objectForKey:key] boolValue] : 0;
}

-(NSInteger)integerValueForKey:(NSObject*)key
{
    return [self objectForKey:key] != nil ? [[self objectForKey:key] integerValue] : 0;
}
-(long)longValueForKey:(NSObject*)key
{
    return [self objectForKey:key] != nil ? [[self objectForKey:key] longValue] : 0;
}
-(float)floatValueForKey:(NSObject*)key
{
    return [self objectForKey:key] != nil ? [[self objectForKey:key] floatValue] : 0;
}

- (BOOL)boolValueForKey:(NSObject*)key
{
    return [self objectForKey:key] != nil ? [[self objectForKey:key] boolValue] : 0;
}
-(NSString*)stringValueForKey:(NSObject*)key
{
    return [self objectForKey:key] != nil ? [NSString stringWithFormat:@"%@",[self objectForKey:key]] : @"";
}

-(NSArray*)arrayForKey:(NSObject*)key
{
    return (NSArray*)[self objectForKey:key];
}

-(NSDictionary*)dictionaryForKey:(NSObject*)key
{
    return (NSDictionary*)[self objectForKey:key];
}

@end
