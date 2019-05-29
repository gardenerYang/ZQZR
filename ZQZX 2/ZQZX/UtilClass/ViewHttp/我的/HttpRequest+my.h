//
//  HttpRequest+my.h
//  ZQZX
//
//  Created by 中企 on 2018/10/26.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest.h"
#import "MyModel.h"
#import "CardModel.h"
#import "CapitalRecordModel.h"
#import "MyOrderModel.h"
#import "MyRecordModel.h"
#import "MyOrderModel.h"
#import "MyOrderDetailsModel.h"
#import "ReimbursementModel.h"
#import "PlanDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HttpRequest (my)
/**
 获取个人信息

 @param success success description
 @param failure failure description
 */
+(void)getMyInformationRequestsuccess:(void (^)(MyModel *myModel ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 实名认证

 @param name name description
 @param idNum idNum description
 @param province province description
 @param city city description
 @param contactAddress contactAddress description
 @param success success description
 @param failure failure description
 */
+(void)getMyauthenticationUserName:(NSString *)name idNum:(NSString *)idNum province:(NSString *)province city:(NSString *)city contactAddress:(NSString *)contactAddress Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 获取卡列表
 @param success success description
 @param failure failure description
 */
+(void)getCardListRequestsuccess:(void (^)(NSArray *cardArr ,NSString *message ))success  failure:(void (^)(NSError *error))failure;


/**
 解绑银行卡

 @param carId 银行卡ID
 @param success success description
 @param failure failure description
 */
+(void)deleteCardID:(NSString *)carId Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;


/**
 绑定银行卡

 @param name 真实姓名
 @param idNum 身份证号
 @param mobile 手机号
 @param cardNo 银行卡号
 @param username 用户id
 @param success success description
 @param failure failure description
 */
+(void)addCardName:(NSString *)name idNum:(NSString *)idNum mobile:(NSString *)mobile cardNo:(NSString *)cardNo username:(NSString *)username  Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

//////////////设置///////////////////
/**
 退出登录

 @param success success description
 @param failure failure description
 */
+(void)exitLogonRequestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;



/**
 意见反馈

 @param opinion 意见
 @param success success description
 @param failure failure description
 */
+(void)suggestionsoOpinion:(NSString *)opinion Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;



/**
 资金记录


 @param pageNum 页码
 @param success success description
 @param failure failure description
 */
+(void)capitalRecordPageNum:(NSInteger )pageNum Requestsuccess:(void (^)(MyRecordModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 我的订单

 @param pageNum 页码
 @param dataStatus 时间范围参数（oneMonth:一个月；threeMonth：三个月；halfMonth:半年；oneYear:一
 @param type 产品类型 0：票据；1：保理；2：房产；3：股权；4：票据直投
 @param status 投资状态 0:待受理;1:待签约;2:已签约;3:签约作废;4:签约不成功;5:已取消;6:已退款;7:待赎回;8:已赎回9:已还款；
 @param success success description
 @param failure failure description
 */
+(void)myOrderPageNum:(NSInteger )pageNum dataStatus:(NSString*)dataStatus type:(NSString*)type status:(NSString*)status Requestsuccess:(void (^)(MyOrderModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure;



/**
 订单详情ID

 @param ordID ordID description
 @param success success description
 @param failure failure description
 */
+(void)myOrderDetailsOrderID:(NSString *)ordID Requestsuccess:(void (^)(MyOrderDetailsModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 取消订单

 @param ordID 订单id
 @param success success description
 @param failure failure description
 */
+(void)cancelOrderID:(NSString *)ordID productID:(NSString *)productID Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 回款计划

 @param pageNum pageNum description
 @param status 待回款：0；已回款：1
 @param success success description
 @param failure failure description
 */
+(void)returnMoneySchemesStatus:(NSInteger )pageNum status:(NSString *)status statusTwo:(NSNumber*)statusTwo Requestsuccess:(void (^)(ReimbursementModel *model,NSString *message ))success  failure:(void (^)(NSError *error))failure;
/**
 回款计划详情

 @param detailsID 回款计划ID
 @param success success description
 @param failure failure description
 */
+(void)returnMoneySchemesdetailsID:(NSString *)detailsID Requestsuccess:(void (^)(PlanDetailsModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 更改手机号

 @param str 老手机old,新手机new
 @param success success description
 @param failure failure description
 */
+(void)changePhone:(NSString *)str phone:(NSString *)phone Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 改变手机号下一步

 @param str 老手机old,新手机new
 @param code 验证码
 @param success success description
 @param failure failure description
 */
+(void)changePhoneNext:(NSString *)str code:(NSString *)code Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;


/**
 更新头像

 @param headPortraitUrl 头像
 @param success success description
 @param failure failure description
 */
+(void)uploadPhoto:(NSString *)headPortraitUrl Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;
+(void)getQuestionList:(NSString *)userId Requestsuccess:(void (^)(NSMutableArray *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
