//
//  BaseClass.m
//  Ninesecretary
//
//  Created by 少爷 on 2017/5/26.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "BaseClass.h"
#import <objc/runtime.h>


@implementation BaseClass

//MJ_replacedKeyFromPropertyName

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivarList = class_copyIvarList([self class], &count);
        
        for (int i=0; i<count; i++) {
            const char *name = ivar_getName(ivarList[i]);
            NSString *strName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:strName];
            [self setValue:value forKey:strName];
        }
        free(ivarList);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivarLists = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        const char* name = ivar_getName(ivarLists[i]);
        NSString* strName = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:strName] forKey:strName];
    }
    free(ivarLists);
}

@end
