//
//  HttpRequest+loginAndRegister.h
//  ZQZX
//
//  Created by 中企 on 2018/10/25.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest.h"
#import "NetworkManager+Base.h"
#import "LoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HttpRequest (loginAndRegister)
/**
 登录

 @param phone 手机号
 @param password 密码
 @param success success description
 @param failure failure description
 */
+(void)goToLogin:(NSString *)phone password:(NSString *)password  Requestsuccess:(void (^)(LoginModel *loginModel))success  failure:(void (^)(NSError *error))failure;




/**
 注册--获取验证码

 @param verificationCodePhone 手机号
 @param fpName 理财师推荐码
 @param success success description
 @param failure failure description
 */

+(void)getVerificationCodePhone:(NSString *)verificationCodePhone fpName:(NSString *)fpName Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 注册下一步提交

 @param phone 手机号
 @param code 验证码
 @param success success description
 @param failure failure description
 */
+(void)registrationNextStep:(NSString *)phone code:(NSString *)code fpName:(NSString *)fpName Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 注册提交

 @param phone 手机号
 @param fpName 理财师推荐码
 @param password 验证码
 @param success success description
 @param failure failure description
 */
+(void)registration:(NSString *)phone fpName:(NSString *)fpName password:(NSString *)password Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;


/**
 忘记密码-验证码

 @param phone 手机号
 @param success success description
 @param failure failure description
 */
+(void)forgetPasswordVerificationCode:(NSString *)phone Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;


/**
 忘记密码提交

 @param phone 手机号
 @param password 验证码
 @param success success description
 @param failure failure description
 */
+(void)forgetPasswordSubmission:(NSString *)phone password:(NSString *)password Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;

/**
 申请理财师

 @param userRealName 用户名
 @param phone 手机号
 @param province 所在省
 @param city 所在市
 @param address 通讯地址
 @param success success description
 @param failure failure description
 */
+(void)ApplyFinancialManager:(NSString *)userRealName phone:(NSString *)phone province:(NSString *)province city:(NSString *)city address:(NSString *)address Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
