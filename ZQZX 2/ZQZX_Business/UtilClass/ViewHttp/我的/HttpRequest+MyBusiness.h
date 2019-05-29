//
//  HttpRequest+BusinessloginAndRegister.h
//  ZQZX
//
//  Created by 中企 on 2018/11/1.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest.h"
#import "MyBusinessModel.h"
#import "MyUserModel.h"
#import "StatisticsModel.h"
#import "BusinessInvestmentModel.h"
#import "AllBusinessInvestmentModel.h"
#import "BusinessOrderModel.h"
#import "BusinessOrderdetailsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HttpRequest (MyBusiness)
/**
 获取个人信息

 @param success success description
 @param failure failure description
 */
+(void)getFinancialPlannerInfoRequestsuccess:(void (^)(MyBusinessModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure;


/**
 获取月统计

 @param success success description
 @param failure failure description
 */
+(void)getMonethStatisticsRequestsuccess:(void (^)(StatisticsModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 全部统计

 @param success success description
 @param failure failure description
 */
+(void)getAllMonethStatisticsRequestsuccess:(void (^)(AllBusinessInvestmentModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure;


/**
 用户投资管理

 @param pageNum pageNum description

 @param success success description
 @param failure failure description
 */
+(void)getBusinessInvestmentPageNum:(NSInteger )pageNum Requestsuccess:(void (^)(BusinessInvestmentModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 获取我的用户

 @param success success description
 @param failure failure description
 */
+(void)getMyUserRequestsuccess:(void (^)(NSArray *arr ,NSString *message ))success  failure:(void (^)(NSError *error))failure;



/**
 我的订单
 
 @param pageNum 页码
 @param dataStatus 时间范围参数（oneMonth:一个月；threeMonth：三个月；halfMonth:半年；oneYear:一
 @param type 产品类型 0：票据；1：保理；2：房产；3：股权；4：票据直投
 @param status 投资状态 0:待受理;1:待签约;2:已签约;3:签约作废;4:签约不成功;5:已取消;6:已退款;7:待赎回;8:已赎回9:已还款；
 @param success success description
 @param failure failure description
 */
+(void)myBusinessOrderPageNum:(NSInteger )pageNum dataStatus:(NSString*)dataStatus type:(NSString*)type status:(NSString*)status Requestsuccess:(void (^)(BusinessOrderModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 我的订单详情

 @param orderID 订单ID
 @param success success description
 @param failure failure description
 */
+(void)mygetBusinessBillDetailById:(NSString *)orderID  Requestsuccess:(void (^)(BusinessOrderdetailsModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 上传打款凭证

 @param investmentId 投资ID
 @param certificateUrl 打款凭证URL
 @param type 凭证类型 0：打款凭证 1：其它凭证
 @param success success description
 @param failure failure description
 */
+(void)mysaveInvestmentCertificateinvestmentId:(NSString *)investmentId certificateUrl:(NSString *)certificateUrl type:(NSString *)type  Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 获取用户银行卡列表

 @param userid 用户ID
 @param success success description
 @param failure failure description
 */
+(void)getBankcardListID:(NSString *)userid Requestsuccess:(void (^)(NSArray *dataArr ,NSString *message ))success  failure:(void (^)(NSError *error))failure;


/**
 提交订单信息

 @param orderId 订单ID
 @param remitBankNo 打款银行卡
 @param repaymentBankNo 回款银行卡
 @param payTime 还款时间
 @param certificateUrl 打款凭证
 @param certificateUrlOther 打款凭证其他
 @param success success description
 @param failure failure description
 */
+(void)submissioninformationID:(NSString *)orderId remitBankNo:(NSString *)remitBankNo repaymentBankNo:(NSString *)repaymentBankNo payTime:(NSString *)payTime certificateUrl:(NSString *)certificateUrl bankInfo:(NSString *)bankInfo certificateUrlOther:(NSString *)certificateUrlOther actualAmount:(NSString *)actualAmount remitWay:(NSString*)remitWay Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 更新理财师信息

 @param ids ids description
 @param corpId <#corpId description#>
 @param employeesNo <#employeesNo description#>
 @param password <#password description#>
 @param username <#username description#>
 @param realname <#realname description#>
 @param phone <#phone description#>
 @param email <#email description#>
 @param rate <#rate description#>
 @param level <#level description#>
 @param levelName <#levelName description#>
 @param province <#province description#>
 @param city <#city description#>
 @param status <#status description#>
 @param addTime <#addTime description#>
 @param addIp <#addIp description#>
 @param superiorId <#superiorId description#>
 @param superiorName <#superiorName description#>
 @param referralCode <#referralCode description#>
 @param headImageUrl <#headImageUrl description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)updateFinancialPlannerInfoID:(NSString *)ids corpId:(NSString *)corpId employeesNo:(NSString *)employeesNo password:(NSString *)password username:(NSString *)username realname:(NSString *)realname phone:(NSString *)phone email:(NSString *)email rate:(NSString *)rate level:(NSString *)level levelName:(NSString *)levelName province:(NSString *)province city:(NSString *)city status:(NSString *)status addTime:(NSString *)addTime addIp:(NSString *)addIp superiorId:(NSString *)superiorId superiorName:(NSString *)superiorName referralCode:(NSString *)referralCode headImageUrl:(NSString *)headImageUrl Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;


/**
 获取旧手机短信验证码

 @param success success description
 @param failure failure description
 */
+(void)changeBusinessPhoneRequestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
修改密码下一步

 @param mobile 手机号
 @param text 验证码
 @param success success description
 @param failure failure description
 */
+(void)changeBusinessPhonemobile:(NSString *)mobile text:(NSString *)text Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 获取新手机验证码

 @param mobile 新手机号
 @param success success description
 @param failure failure description
 */
+(void)changeBusinessNewPhone:(NSString *)mobile Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
修改手机号下一步提交确定

 @param mobile 手机号
 @param text 验证码
 @param success success description
 @param failure failure description
 */
+(void)changeBusinessNewPhonemobile:(NSString *)mobile text:(NSString *)text Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 更新密码

 @param mobile 手机号
 @param newPassword 新密码
 @param success success description
 @param failure failure description
 */
+(void)updatePasswordMobile:(NSString *)mobile newPassword:(NSString *)newPassword Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
