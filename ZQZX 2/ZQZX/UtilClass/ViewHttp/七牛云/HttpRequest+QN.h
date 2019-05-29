//
//  HttpRequest+QN.h
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest.h"
#import "QNModel.h"
#import <Qiniu/QiniuSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpRequest (QN)
/**
 七牛云获取token

 @param success success description
 @param failure failure description
 */
+(void)getQNTokenRequestsuccess:(void (^)(QNModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
