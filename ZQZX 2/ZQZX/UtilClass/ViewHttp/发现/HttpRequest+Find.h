//
//  HttpRequest+Find.h
//  ZQZX
//
//  Created by 中企 on 2018/10/25.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest.h"
#import "FindModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HttpRequest (Find)
/**
 发现界面

 @param pageNum 页码
 @param type 类型 1:行业 2:公司动态
 @param success success description
 @param failure failure description
 */
+(void)getFindDataPageNum:(NSInteger )pageNum type:(NSString *)type Requestsuccess:(void (^)(FindModel *findMode ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
