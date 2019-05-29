//
//  HttpRequest+my.m
//  ZQZX
//
//  Created by 中企 on 2018/10/26.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest+my.h"
#import "QAModel.h"
@implementation HttpRequest (my)
+(void)getMyInformationRequestsuccess:(void (^)(MyModel *myModel ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    [HttpRequest post:my_homePage param:nil success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.data);
        MyModel *myModel = [MyModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(myModel,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)getMyauthenticationUserName:(NSString *)name idNum:(NSString *)idNum province:(NSString *)province city:(NSString *)city contactAddress:(NSString *)contactAddress Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"name": name , @"idNum": idNum , @"province": province , @"city": city , @"contactAddress": contactAddress };
    [HttpRequest post:my_authenticationUser param:paramDic success:^(HttpResponse *data,NSString *message) {
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
+(void)getCardListRequestsuccess:(void (^)(NSArray *cardArr ,NSString *message ))success  failure:(void (^)(NSError *error))failure;{
    [HttpRequest post:my_bankCardList param:nil success:^(HttpResponse *data,NSString *message) {
        NSArray *cardArr = [CardModel mj_objectArrayWithKeyValuesArray:data.data];
        if (success) {
            success(cardArr,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)deleteCardID:(NSString *)carId Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
       NSDictionary *paramDic = @{ @"id": carId};
    [HttpRequest post:my_unbindBankCard param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data.data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+(void)addCardName:(NSString *)name idNum:(NSString *)idNum mobile:(NSString *)mobile cardNo:(NSString *)cardNo username:(NSString *)username  Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"name": name , @"idNum": idNum , @"mobile": mobile , @"cardNo": cardNo , @"username": username };

    [HttpRequest post:my_bankCheck param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
//////////////////设置///////////////////
+(void)exitLogonRequestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    [HttpRequest post:my_setting_doLogout param:nil success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)suggestionsoOpinion:(NSString *)opinion Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"opinion": opinion };
    [HttpRequest post:my_setting_opinion param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)capitalRecordPageNum:(NSInteger )pageNum Requestsuccess:(void (^)(MyRecordModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"pageNum": @(pageNum).stringValue , @"pageSize": @"10"  };
    [HttpRequest post:my_moneyRecord param:paramDic success:^(HttpResponse *data,NSString *message) {
        MyRecordModel *recordMode = [MyRecordModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(recordMode,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)myOrderPageNum:(NSInteger )pageNum dataStatus:(NSString*)dataStatus type:(NSString*)type status:(NSString*)status Requestsuccess:(void (^)(MyOrderModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    
    NSDictionary *paramDic = @{@"pageNum": @(pageNum).stringValue , @"pageSize": @"10" ,@"dataStatus": dataStatus ,@"type": type , @"status": status };
      NSLog(@"上传的数据是%@",paramDic);
    [HttpRequest post:my_indent param:paramDic success:^(HttpResponse *data,NSString *message) {
        MyOrderModel *model = [MyOrderModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)returnMoneySchemesStatus:(NSInteger )pageNum status:(NSString *)status statusTwo:(NSNumber*)statusTwo Requestsuccess:(void (^)(ReimbursementModel *model,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"pageNum": @(pageNum).stringValue , @"pageSize": @"10" , @"status": status,@"statusTwo":statusTwo};
    [HttpRequest post:my_returnMoneySchemes param:paramDic success:^(HttpResponse *data,NSString *message) {
        ReimbursementModel *model = [ReimbursementModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)returnMoneySchemesdetailsID:(NSString *)detailsID Requestsuccess:(void (^)(PlanDetailsModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"id": detailsID==nil?@"":detailsID};
    
    [HttpRequest post:my_schemesDetails param:paramDic success:^(HttpResponse *data,NSString *message) {
        PlanDetailsModel *model = [PlanDetailsModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)myOrderDetailsOrderID:(NSString *)ordID Requestsuccess:(void (^)(MyOrderDetailsModel *model ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"id": ordID  };
    
    [HttpRequest post:my_indentDetails param:paramDic success:^(HttpResponse *data,NSString *message) {
        MyOrderDetailsModel *model = [MyOrderDetailsModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)cancelOrderID:(NSString *)ordID productID:(NSString *)productID  Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{@"id": ordID ,@"productId":productID};
    
    [HttpRequest post:my_cancelDetails param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data.data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}



+(void)changePhone:(NSString *)str phone:(NSString *)phone Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic;
    if (phone == nil) {
     paramDic = @{ @"str": str};
    }else{
     paramDic = @{ @"str": str ,@"phone": phone};
    }
    [HttpRequest post:my_setting_changePhone param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)changePhoneNext:(NSString *)str code:(NSString *)code Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic;
    paramDic = @{ @"str": str ,@"code": code};
    [HttpRequest post:my_setting_nextStep param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)uploadPhoto:(NSString *)headPortraitUrl Requestsuccess:(void (^)(HttpResponse *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"headPortraitUrl": headPortraitUrl };
    [HttpRequest post:my_upload param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)getQuestionList:(NSString *)userId Requestsuccess:(void (^)(NSMutableArray *data ,NSString *message ))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"userId": userId};
    [HttpRequest post:my_getQuestionList param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            NSMutableArray * arr = [NSMutableArray array];
            for (NSDictionary * dic in data.data) {
                [arr addObject:[QAModel mj_objectWithKeyValues:dic]];
            }
            success(arr,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
