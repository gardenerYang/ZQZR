//
//  NSError+Util.m
//  Assistant
//
//  Created by 少爷 on 2017/5/24.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "NSError+Util.h"

@implementation NSError (Util)

- (id)otherData {
    return self.userInfo[@"otherData"];
}

+ (instancetype)errorWithCode:(ResponseStatus)code mag:(NSString *)msg otherData:(id)otherData {
    if (msg ==nil) {
        NSMutableDictionary *userInfo = [@{NSLocalizedDescriptionKey: @"请求失败"} mutableCopy];
        NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:userInfo];
        return error;
    }
    NSMutableDictionary *userInfo = [@{NSLocalizedDescriptionKey: msg} mutableCopy];
    
    if (otherData != nil) {
        [userInfo setObject:otherData forKey:@"otherData"];
    }
    
    NSError *error = [NSError errorWithDomain:@"" code:code userInfo:userInfo];
    return error;
}

+ (instancetype)errorWithCode:(ResponseStatus)code msg:(NSString *)msg {
    return [NSError errorWithCode:code mag:msg otherData:nil];
}

+ (instancetype)errorWithMsg:(NSString *)msg {
    return [NSError errorWithCode:ResponseStatusSuccess msg:msg];
}

@end
