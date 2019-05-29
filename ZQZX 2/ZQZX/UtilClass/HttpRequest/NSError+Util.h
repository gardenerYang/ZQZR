//
//  NSError+Util.h
//  Assistant
//
//  Created by 少爷 on 2017/5/24.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpResponse.h"

@interface NSError (Util)

@property (nonatomic, strong, readonly) id otherData;

+ (instancetype)errorWithCode:(ResponseStatus)code mag:(NSString *)msg otherData:(id)otherData;
+ (instancetype)errorWithCode:(ResponseStatus)code msg:(NSString *)msg;
+ (instancetype)errorWithMsg:(NSString *)msg;

@end
