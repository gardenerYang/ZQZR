//
//  HttpRequest+Find.m
//  ZQZX
//
//  Created by 中企 on 2018/10/25.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest+Find.h"

@implementation HttpRequest (Find)
+(void)getFindDataPageNum:(NSInteger )pageNum type:(NSString *)type Requestsuccess:(void (^)(FindModel *findMode ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"type": type , @"pageNum": @(pageNum).stringValue , @"pageSize": @"10" };
    [HttpRequest post:find_getMomentByParam param:paramDic success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.data);
        FindModel *findMode = [FindModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(findMode,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
