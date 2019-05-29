//
//  BaseClass.h
//  Ninesecretary
//
//  Created by 少爷 on 2017/5/26.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MJ_replacedKeyFromPropertyName + (NSDictionary *)mj_replacedKeyFromPropertyName { return @{ @"simpleInfo": @"description" }; }

@interface BaseClass : NSObject <NSCoding>

@end
