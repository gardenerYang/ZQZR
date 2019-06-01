//
//  HttpRequest+Home.m
//  ZQZX
//
//  Created by 中企 on 2018/10/18.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HttpRequest+Home.h"
@implementation HttpRequest (Home)
+(void)achieveImgWithState:(NSString*)state Requestsuccess:(void (^)(NSArray *imgArr))success  failure:(void (^)(NSError *error))failure{
    [HttpRequest post:http_home_getSysScrollImages param:@{@"bannerState":state} success:^(HttpResponse *data,NSString *message) {
        NSArray *arr = [ImgModel mj_objectArrayWithKeyValuesArray:data.data];
        NSLog(@"哈哈哈-----------%@",arr);

        if (success) {
            success(arr);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)getTopOrSuggInvestionsRequestsuccess:(void (^)(HomeModel *homeModel ,NSString *message))success  failure:(void (^)(NSError *error))failure{
    [HttpRequest post:home_getTopOrSuggInvestions param:nil success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.data);
        HomeModel *homeMode = [HomeModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(homeMode,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)homeRemindUserOrFinancialPlannersuccess:(void (^)(NSArray *listArr))success  failure:(void (^)(NSError *error))failure{
    [HttpRequest post:home_remindUserOrFinancialPlanner param:nil success:^(HttpResponse *data,NSString *message) {
        NSArray *arr = [InveItem mj_objectArrayWithKeyValuesArray:data.data];
        if (success) {
            success(arr);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)getHomeListPageNum:(NSInteger )pageNum type:(NSString *)type Requestsuccess:(void (^)(HomeListModel *model ,NSString *message))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"type": type , @"pageNum": @(pageNum).stringValue , @"pageSize": @"10" , @"duration": @"0"};

    [HttpRequest post:home_getHomeProductsByParam param:paramDic success:^(HttpResponse *data,NSString *message) {
        HomeListModel *model = [HomeListModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)getHomeListDetailsID:(NSString *)productID  Requestsuccess:(void (^)(ProductDetailsModel *model ,NSString *message))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"id": productID};
    [HttpRequest post:home_getProductDetail param:paramDic success:^(HttpResponse *data,NSString *message) {
        ProductDetailsModel *model = [ProductDetailsModel mj_objectWithKeyValues:data.data];
        if (success) {
            success(model,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)getRecordListID:(NSString *)productID  Requestsuccess:(void (^)(NSArray *listArr ,NSString *message))success  failure:(void (^)(NSError *error))failure{
    
    NSDictionary *paramDic = @{ @"productId": productID};
    [HttpRequest post:home_getProductLog param:paramDic success:^(HttpResponse *data,NSString *message) {
        RecordListModel *model = [RecordListModel mj_objectWithKeyValues:data.data];
        NSArray *arr = model.cList;
        if (success) {
            success(arr,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)getTicketInfomationID:(NSString *)productID  Requestsuccess:(void (^)(NSArray *listArr ,NSString *message))success  failure:(void (^)(NSError *error))failure{
    NSDictionary *paramDic = @{ @"productId": productID};
    [HttpRequest post:home_getProductTicketsByPId param:paramDic success:^(HttpResponse *data,NSString *message) {
        NSArray * arr = data.data;
        if (success) {
            success(arr,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)getAppointmentID:(NSString *)productID subscribeAmount:(NSString *)subscribeAmount status:(NSNumber*)status strategyNumber:(NSString*)strategyNumber Requestsuccess:(void (^)(HttpResponse *data ,NSString *message))success  failure:(void (^)(NSError *error))failure{
//    产品类型（票据，保理，直投、股权、房产），0-4
    NSDictionary *paramDic = @{ @"productId": productID , @"subscribeAmount": subscribeAmount,@"status":status,@"strategyNumber":strategyNumber};
    [HttpRequest post:home_makeReservation param:paramDic success:^(HttpResponse *data,NSString *message) {
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)getUpdateRequestsuccess:(void (^)(HttpResponse *data ,NSString *message))success  failure:(void (^)(NSError *error))failure{
#if BusinessTag
    NSDictionary *paramDic = @{ @"v": @"1" , @"type":@"1", @"userId":[AppUserProfile sharedInstance].userId};
#else
    NSDictionary *paramDic = @{ @"v": @"1" , @"type":@"", @"userId":[AppUserProfile sharedInstance].userId};

#endif
    [HttpRequest post:@"commonSetting/getVersion" param:paramDic success:^(HttpResponse *data, NSString *message) {
        if (success) {
            success(data,message);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

@end
