//
//  HttpRequest+BusinessloginAndRegister.m
//  ZQZX
//
//  Created by 中企 on 2018/11/1.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest+MyBusiness.h"
#import "NetworkManager+Base.h"
@implementation HttpRequest (BusinessloginAndRegister)
+(void)getFinancialPlannerInfoRequestsuccess:(void (^)(MyBusinessModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"id":[AppUserProfile sharedInstance].userId,@"userId":[AppUserProfile sharedInstance].userId};
    [HttpRequest post:my_Business_getFinancialPlannerInfo param:paramDic success:^(HttpResponse *data,NSString *message) {
        MyBusinessModel *model = [MyBusinessModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 获取月统计
 
 @param success success description
 @param failure failure description
 */
+(void)getMonethStatisticsRequestsuccess:(void (^)(StatisticsModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary * dic = @{@"userId":[AppUserProfile sharedInstance].userId};
    [HttpRequest post:Business_achievementCount param:dic success:^(HttpResponse *data,NSString *message) {
        StatisticsModel *model = [StatisticsModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)getAllMonethStatisticsRequestsuccess:(void (^)(AllBusinessInvestmentModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary * dic = @{@"userId":[AppUserProfile sharedInstance].userId};
    [HttpRequest post:Business_achievementCountAll param:dic success:^(HttpResponse *data,NSString *message) {
        AllBusinessInvestmentModel *model = [AllBusinessInvestmentModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}




+(void)getBusinessInvestmentPageNum:(NSInteger )pageNum Requestsuccess:(void (^)(BusinessInvestmentModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"pageNum": @(pageNum).stringValue , @"pageSize": @"10" ,@"userId":[AppUserProfile sharedInstance].userId};
    [HttpRequest post:Business_getUserInvestmentManager param:paramDic success:^(HttpResponse *data,NSString *message) {
        BusinessInvestmentModel *model = [BusinessInvestmentModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)getMyUserRequestsuccess:(void (^)(NSArray *arr  ,NSString *message ))success  failure:(void (^)(NSError *error))failure {
    NSDictionary * dic = @{@"userId":[AppUserProfile sharedInstance].userId};
    [HttpRequest post:Business_getCustomers param:dic success:^(HttpResponse *data,NSString *message) {
        NSArray *dataArr = [MyUserModel mj_objectArrayWithKeyValuesArray:data.data];
        if (success) {
            success(dataArr,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)myBusinessOrderPageNum:(NSInteger )pageNum dataStatus:(NSString*)dataStatus type:(NSString*)type status:(NSString*)status Requestsuccess:(void (^)(BusinessOrderModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    
    NSDictionary *paramDic = @{@"pageNum": @(pageNum).stringValue , @"pageSize": @"10" ,@"duration": dataStatus ,@"pType": type , @"status": status,@"userId":[AppUserProfile sharedInstance].userId};
  
    [HttpRequest post:Business_getInvestmentByParam param:paramDic success:^(HttpResponse *data,NSString *message) {
        BusinessOrderModel *model = [BusinessOrderModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)mygetBusinessBillDetailById:(NSString *)orderID  Requestsuccess:(void (^)(BusinessOrderdetailsModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"id": orderID,@"userId":[AppUserProfile sharedInstance].userId};
    
    [HttpRequest post:Business_getBillDetailById param:paramDic success:^(HttpResponse *data,NSString *message) {
        BusinessOrderdetailsModel *model  = [BusinessOrderdetailsModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)mysaveInvestmentCertificateinvestmentId:(NSString *)investmentId certificateUrl:(NSString *)certificateUrl type:(NSString *)type  Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"investmentId": investmentId , @"certificateUrl": certificateUrl ,@"type": type,@"userId":[AppUserProfile sharedInstance].userId};
    
    [HttpRequest post:Business_saveInvestmentCertificate param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data.data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)getBankcardListID:(NSString *)userid Requestsuccess:(void (^)(NSArray *dataArr ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"id": userid,@"userId":[AppUserProfile sharedInstance].userId};
    [HttpRequest post:Business_getBankNoByInvestmentId param:paramDic success:^(HttpResponse *data,NSString *message) {
        NSArray *arr = data.data;
        if (success) {
            success(arr,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)submissioninformationID:(NSString *)orderId remitBankNo:(NSString *)remitBankNo repaymentBankNo:(NSString *)repaymentBankNo payTime:(NSString *)payTime certificateUrl:(NSString *)certificateUrl bankInfo:(NSString *)bankInfo certificateUrlOther:(NSString *)certificateUrlOther actualAmount:(NSString *)actualAmount remitWay:(NSString*)remitWay Requestsuccess:(void (^)(HttpResponse *data,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    
    NSDictionary *paramDic = @{@"id": orderId ,@"remitBankNo": remitBankNo ,@"repaymentBankNo": repaymentBankNo ,@"payTimeStr": payTime ,@"certificateUrl": certificateUrl ,@"certificateUrlOther": certificateUrlOther ,@"bankInfo": bankInfo ,@"actualAmount":actualAmount,@"userId":[AppUserProfile sharedInstance].userId,@"remitWay":remitWay};
    [HttpRequest post:Business_updateInvestmentById param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data.data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)updateFinancialPlannerInfoID:(NSString *)ids corpId:(NSString *)corpId employeesNo:(NSString *)employeesNo password:(NSString *)password username:(NSString *)username realname:(NSString *)realname phone:(NSString *)phone email:(NSString *)email rate:(NSString *)rate level:(NSString *)level levelName:(NSString *)levelName province:(NSString *)province city:(NSString *)city status:(NSString *)status addTime:(NSString *)addTime addIp:(NSString *)addIp superiorId:(NSString *)superiorId superiorName:(NSString *)superiorName referralCode:(NSString *)referralCode headImageUrl:(NSString *)headImageUrl Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic;
    if (addTime.length == 0) {
          paramDic = @{@"id": ids ,@"corpId": corpId ,@"employeesNo": employeesNo ,@"password": password ,@"username": username ,@"realname": realname ,@"phone": phone ,@"email": email ,@"rate": rate ,@"level": level ,@"levelName": levelName ,@"province": province ,@"city": city ,@"status": status ,@"addIp": addIp ,@"superiorId": superiorId ,@"superiorName": superiorName ,@"referralCode": referralCode ,@"headImageUrl": headImageUrl,@"userId":[AppUserProfile sharedInstance].userId};
    }
    else{
    paramDic = @{@"id": ids ,@"corpId": corpId ,@"employeesNo": employeesNo ,@"password": password ,@"username": username ,@"realname": realname ,@"phone": phone ,@"email": email ,@"rate": rate ,@"level": level ,@"levelName": levelName ,@"province": province ,@"city": city ,@"status": status ,@"addTime": addTime ,@"addIp": addIp ,@"superiorId": superiorId ,@"superiorName": superiorName ,@"referralCode": referralCode ,@"headImageUrl": headImageUrl,@"userId":[AppUserProfile sharedInstance].userId};
    }
    [HttpRequest post:Business_updateFinancialPlannerInfo param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data.data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)changeBusinessPhoneRequestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    
    [HttpRequest post:Business_getOldTextCode param:@{@"userId":[AppUserProfile sharedInstance].userId} success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data.data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)changeBusinessPhonemobile:(NSString *)mobile text:(NSString *)text Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"mobile": mobile , @"text": text,@"userId":[AppUserProfile sharedInstance].userId};
    
    [HttpRequest post:Business_checkTextCode param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data.data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
+(void)changeBusinessNewPhone:(NSString *)mobile Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    
    NSDictionary *paramDic = @{@"mobile": mobile,@"userId":[AppUserProfile sharedInstance].userId};
    
    [HttpRequest post:Business_sendText param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data.data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)changeBusinessNewPhonemobile:(NSString *)mobile text:(NSString *)text Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"mobile": mobile , @"text": text,@"userId":[AppUserProfile sharedInstance].userId};
    [HttpRequest post:Business_updatePhone param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data.data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)updatePasswordMobile:(NSString *)mobile newPassword:(NSString *)newPassword Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"mobile": mobile , @"newPassword":  [self passwordMD5:newPassword],@"userId":[AppUserProfile sharedInstance].userId};

    [HttpRequest post:Business_updatePassword param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data.data,message);
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
