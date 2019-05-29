//
//  HttpRequest+Active.h
//  ZQZX
//
//  Created by 中企 on 2018/10/26.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest.h"
#import "ActiveModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HttpRequest (Active)
/**
 获取活动数据

 @param success success description
 @param failure failure description
 */
+(void)getActiveDataRequestsuccess:(void (^)(NSArray *dataArr ,NSString *message ))success  failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
