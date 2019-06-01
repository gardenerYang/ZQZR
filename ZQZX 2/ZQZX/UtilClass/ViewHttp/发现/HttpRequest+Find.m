//
//  HttpRequest+Find.m
//  ZQZX
//
//  Created by 中企 on 2018/10/25.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest+Find.h"

@implementation HttpRequest (Find)
//行业新闻是1 企业新闻是2
+(void)getFindDataPageNum:(NSInteger )pageNum type:(NSString *)type home:(NSString*)home Requestsuccess:(void (^)(FindModel *findMode ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic;
    if ([home isEqualToString:@"1"]) {
        paramDic = @{ @"type": type , @"pageNum": @(pageNum).stringValue , @"pageSize": @"10",@"home":home};
    }else{
        paramDic = @{ @"type": type , @"pageNum": @(pageNum).stringValue , @"pageSize": @"10" };    }
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
