//
//  HttpRequest+Home.h
//  ZQZX
//
//  Created by 中企 on 2018/10/18.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest.h"
#import "ImgModel.h"
#import "HomeModel.h"
#import "HomeListModel.h"
#import "ProductDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HttpRequest (Home)
/**
 获取轮播图

 @param success success description
 @param failure failure description
 //首页不传 发现页传2
 */
+(void)achieveImgWithState:(NSString*)state Requestsuccess:(void (^)(NSArray *imgArr))success  failure:(void (^)(NSError *error))failure;

/**
 获取首页数据

 @param success success description
 @param failure failure description
 */
+(void)getTopOrSuggInvestionsRequestsuccess:(void (^)(HomeModel *homeModel ,NSString *message))success  failure:(void (^)(NSError *error))failure;

/**
 首页票据列表

 @param pageNum 页码
 @param type 产品类型 0：票据；1：保理；2：房产；3：股权；4：票据直投
 @param success success description
 @param failure failure description
 */
+(void)getHomeListPageNum:(NSInteger )pageNum type:(NSString *)type Requestsuccess:(void (^)(HomeListModel *model ,NSString *message))success  failure:(void (^)(NSError *error))failure;

/**
 获取产品详情

 @param productID 产品oid
 @param success success description
 @param failure failure description
 */
+(void)getHomeListDetailsID:(NSString *)productID  Requestsuccess:(void (^)(ProductDetailsModel *model ,NSString *message))success  failure:(void (^)(NSError *error))failure;

/**
 获取详情-预约记录

 @param productID 产品ID
 @param success success description
 @param failure failure description
 */
+(void)getRecordListID:(NSString *)productID  Requestsuccess:(void (^)(NSArray *listArr ,NSString *message))success  failure:(void (^)(NSError *error))failure;

/**
 预约提交

 @param productID 产品ID
 @param subscribeAmount 预约金额
 @param success success description
 @param failure failure description
 */
+(void)getAppointmentID:(NSString *)productID subscribeAmount:(NSString *)subscribeAmount status:(NSNumber*)status strategyNumber:(NSString*)strategyNumber Requestsuccess:(void (^)(HttpResponse *data ,NSString *message))success  failure:(void (^)(NSError *error))failure;
+(void)getTicketInfomationID:(NSString *)productID  Requestsuccess:(void (^)(NSArray *listArr ,NSString *message))success  failure:(void (^)(NSError *error))failure;
+(void)getUpdateRequestsuccess:(void (^)(HttpResponse *data ,NSString *message))success  failure:(void (^)(NSError *error))failure;
+(void)homeRemindUserOrFinancialPlannersuccess:(void (^)(NSArray *listArr))success  failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
