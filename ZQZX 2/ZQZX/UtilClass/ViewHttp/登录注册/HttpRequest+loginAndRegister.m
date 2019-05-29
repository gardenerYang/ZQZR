//
//  HttpRequest+loginAndRegister.m
//  ZQZX
//
//  Created by 中企 on 2018/10/25.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest+loginAndRegister.h"

@implementation HttpRequest (loginAndRegister)
+(void)goToLogin:(NSString *)phone password:(NSString *)password  Requestsuccess:(void (^)(LoginModel *loginModel))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"phone": phone, @"password": [self passwordMD5:password]};

    [HttpRequest post:login_doLogin param:paramDic success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.data);
        LoginModel *loginModel = [LoginModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(loginModel);
        }
    } failure:^(NSError *error) {
        if (failure) {
            [MBProgressHUD hideHUD];
            failure(error);
        }
    }];
}


/**
 注册--获取验证码
 
 @param verificationCodePhone 手机号
 @param fpName 理财师推荐码
 @param success success description
 @param failure failure description
 */

+(void)getVerificationCodePhone:(NSString *)verificationCodePhone fpName:(NSString *)fpName Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    
    NSDictionary *paramDic = @{ @"phone": verificationCodePhone, @"fpName": fpName};

    [HttpRequest post:register_sendCode param:paramDic success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.data);
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)registrationNextStep:(NSString *)phone code:(NSString *)code fpName:(NSString *)fpName Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"phone": phone, @"code": code , @"fpName": fpName};
    
    [HttpRequest post:nextStep param:paramDic success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.data);
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+(void)registration:(NSString *)phone fpName:(NSString *)fpName password:(NSString *)password Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"phone": phone,@"fpName":fpName, @"password": [self passwordMD5:password]};
    [HttpRequest post:register_register param:paramDic success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.data);
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}



+(void)forgetPasswordVerificationCode:(NSString *)phone Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"phone": phone};
    [HttpRequest post:pwd_forgetPassword param:paramDic success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.data);
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)forgetPasswordSubmission:(NSString *)phone password:(NSString *)password Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"phone": phone ,@"password": [self passwordMD5:password]};
    [HttpRequest post:pwd_forgetPassword_forgetPwSub param:paramDic success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.data);
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)ApplyFinancialManager:(NSString *)userRealName phone:(NSString *)phone province:(NSString *)province city:(NSString *)city address:(NSString *)address Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"userRealName": userRealName ,@"phone": phone ,@"province": province , @"city": city , @"address": address};
    [HttpRequest post:register_financialPlanner param:paramDic success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.data);
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+(NSString *)passwordMD5:(NSString *)password{
    NSString *md5Password =[NetworkManager md5WithString:password];
    return md5Password;
}

@end
