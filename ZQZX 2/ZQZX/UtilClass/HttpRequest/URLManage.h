//
//  URLManage.h
//  baianlicai
//
//  Created by 张豪 on 2018/8/13.
//  Copyright © 2018年 Yosef Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLManage : NSObject
+ (NSString *)getCurrentBaseUrl;

+(NSString*)urlWithAPI:(NSString*)URLString;

@end
