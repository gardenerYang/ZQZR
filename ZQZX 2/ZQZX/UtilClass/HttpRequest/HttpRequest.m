//
//  ASHttpRequest.m
//  Assistant
//
//  Created by 少爷 on 2017/5/24.
//  Copyright © 2017年 张豪. All rights reserved.

#import "HttpRequest.h"
#import "URLManage.h"
#import "NSNotificationCenter+Util.h"
#import "NSError+Util.h"
#import "AppUserProfile.h"
@implementation HttpRequest

+ (void)get:(NSString *)relativeUrl param:(id)param success:(void (^)(HttpResponse *data ,NSString *message ))success failure:(void (^)(NSError *))failure {
    NSString *url = [URLManage urlWithAPI:relativeUrl];
    [NetworkManager getWithURLString:url parameters:param success:^(id  _Nonnull responseObject) {
        HttpResponse *response = [HttpResponse mj_objectWithKeyValues:responseObject];
        if (response.code.integerValue == ResponseStatusSuccess) {
            success(response,response.message);
        } else {
            NSError *error = [NSError errorWithCode:response.code.integerValue mag:response.message otherData:response.result];
            failure(error);
        }
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)post:(NSString *)relativeUrl param:(id)param success:(void (^)(HttpResponse *data ,NSString *message ))success failure:(void (^)(NSError *))failure {
  [NetworkManager postWithURLString:[URLManage urlWithAPI:relativeUrl] parameters:param success:^(id  _Nonnull responseObject) {
      NSLog(@"%@",[URLManage urlWithAPI:relativeUrl]);
      NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
      NSLog(@"------%@",rootDic);
        HttpResponse *response = [HttpResponse mj_objectWithKeyValues:responseObject];
        if (response.code.integerValue == ResponseStatusSuccess) {
            success(response ,response.message);
        }else if (response.code.integerValue == ResponseStatusTOKEN_ERROR){//无权限访问
            [[AppUserProfile sharedInstance] cleanUp];
            NSError *error = [NSError errorWithCode:response.code.integerValue mag:response.message otherData:response.result];
            failure(error);
            [MBProgressHUD hideHUD];


        } else {
            [MBProgressHUD hideHUD];

            NSError *error = [NSError errorWithCode:response.code.integerValue mag:response.message otherData:response.result];
           /* switch (error.code) {
                case ResponseStatusLoginTimeOut:
                {
//                    [[UserManage share] toLogout];
                }
                    break;
                case ResponseStatusNonData:
                {
                    
                }
                    break;
                    
                default:
                    
                    break;
            }
            
            */
            failure(error);
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];

        failure(error);
    }];
}

+ (void)postForList:(NSString *)relativeUrl param:(id)param success:(void (^)(HttpListResponse *data ,NSString *message ))success failure:(void (^)(NSError *error))failure; {
    [NetworkManager postWithURLString:[URLManage urlWithAPI:relativeUrl] parameters:param success:^(id  _Nonnull responseObject) {
        HttpListResponse *response = [HttpListResponse mj_objectWithKeyValues:responseObject];
        if (response.code.integerValue == ResponseStatusSuccess) {
            if (response.isFinish) {
                [JGNotifyCenter postNotificationName:JGTableNoMoreData object:nil];
            }
            success(response,response.message);
        } else {
            NSError *error = [NSError errorWithCode:response.code.integerValue mag:response.message otherData:response.otherData];
           /* switch (error.code) {
                case ResponseStatusLoginTimeOut:
                {
//                    [[UserManage share] toLogout];
                }
                    break;
                case ResponseStatusNonData:
                {
                    [JGNotifyCenter postNotificationName:JGTableNoMoreData object:nil];
                }
                    break;
                    
                default:
                    
                    break;
                    
            }*/
            failure(error);
        }
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}


@end
