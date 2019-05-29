//
//  HttpRequest+Active.m
//  ZQZX
//
//  Created by 中企 on 2018/10/26.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest+Active.h"

@implementation HttpRequest (Active)
+(void)getActiveDataRequestsuccess:(void (^)(NSArray *dataArr ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    [HttpRequest post:activity_homePage param:nil success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.data);
        NSArray *arr = [ActiveModel mj_objectArrayWithKeyValuesArray:data.data];
        if (success) {
            success(arr,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
