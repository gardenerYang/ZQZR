//
//  YSSafeFramework.h
//  SafeObjectCrash
//
//  Created by yangshuai on 2018/11/27.
//  Copyright © 2018年 danielYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface YSSafeFramework : NSObject

@end
@interface NSObject (YSSwizzling)

@end
@interface NSArray (YSSafeFramework)

@end
@interface NSMutableArray (YSSafeFramework)

@end
@interface NSDictionary (YSSafeFramework)

@end
@interface NSMutableString (YSSafeFramework)

@end
