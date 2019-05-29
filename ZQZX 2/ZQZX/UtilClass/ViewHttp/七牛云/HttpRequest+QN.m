//
//  HttpRequest+QN.m
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest+QN.h"

@implementation HttpRequest (QN)
+(void)getQNTokenRequestsuccess:(void (^)(QNModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary * dic = @{@"userId":[AppUserProfile sharedInstance].userId};
    [HttpRequest post:getQiniuToken param:dic success:^(HttpResponse *data,NSString *message) {
        QNModel *modl = [QNModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(modl,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
