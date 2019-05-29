//
//  NSDictionary+ValueAccess.h
//  ZhongRongJinFu
//
//  Created by Yosef Lin on 9/9/15.
//  Copyright (c) 2015 Yosef Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(ValueAccess)

-(BOOL)booleanValueForKey:(NSObject*)key;
-(NSInteger)integerValueForKey:(NSObject*)key;
-(long)longValueForKey:(NSObject*)key;
-(float)floatValueForKey:(NSObject*)key;
-(NSString*)stringValueForKey:(NSObject*)key;
-(NSArray*)arrayForKey:(NSObject*)key;
-(NSDictionary*)dictionaryForKey:(NSObject*)key;
- (BOOL)boolValueForKey:(NSObject*)key;

@end
