//
//  ASNetworkManager.m
//  Assistant
//
//  Created by 少爷 on 2017/5/24.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "NetworkManager.h"
#import "AppUserProfile.h"
#import "NetworkManager+Base.h"
#import "RequestedURL.h"
#import <AdSupport/AdSupport.h>

@implementation NetworkManager

//+ (void)cancelRequestWithVC:(ZHViewController *)vc {
//
//    for (NSURLSessionDataTask *task in vc.sessionArr) {
//        NSLog(@"%@的请求停止了", NSStringFromClass([vc class]));
//        [task cancel];
//    }
//}

#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id _Nonnull))success
                 failure:(void (^)(NSError * _Nonnull))failure {
    
    [self requestWithURLString:URLString parameters:parameters type:HttpRequestTypeGet uploadParam:nil progress:nil success:success failure:failure];
}

#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id _Nonnull))success
                  failure:(void (^)(NSError * _Nonnull))failure {
    
    [self requestWithURLString:URLString parameters:parameters type:HttpRequestTypePost uploadParam:nil progress:nil success:success failure:failure];
}

#pragma mark -- 上传图片 --
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:( UploadParam *)uploadParam
                   progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                    success:(void (^)(id _Nonnull ))success
                    failure:(void (^)(NSError * _Nonnull))failure {
    
    [self requestWithURLString:URLString parameters:parameters type:HttpRequestTypeUpload uploadParam:uploadParam progress:uploadProgress success:success failure:failure];
}

#pragma mark -- POST/GET/Upload网络请求 --
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)dic
                        type:(HttpRequestType)type
                 uploadParam:(UploadParam *)uploadParam
                    progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                     success:(void (^)(id _Nonnull))success
                     failure:(void (^)(NSError * _Nonnull))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //可以接受的类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", nil];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"x-requested-with"];
//    NSString *key=[NSUserDefaults getSaveLoginKey];
//    NSString *secret=[NSUserDefaults getSaveLoginSecret];
//    if (key.length>0&&secret.length>0) {
//        [manager.requestSerializer setValue:key forHTTPHeaderField:@"key"];
//        [manager.requestSerializer setValue:secret forHTTPHeaderField:@"secret"];
//    }
    NSDictionary *parameters = [NetworkManager dictionaryByAddingCommonParameters:dic];
    
    NSURLSessionDataTask *currentTask = nil;
    
    switch(type) {
        case HttpRequestTypeGet: {
            currentTask = [manager GET:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                if (success != nil) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull
                        error) {
                if (failure != nil ) {
                    failure(error);
                }
            }];
            break;
        }
            
        case HttpRequestTypePost: {
            currentTask = [manager POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (success != nil) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull
                        error) {
                if (failure != nil) {
                    failure(error);
                }
            }];
            break;
        }
            
        case HttpRequestTypeUpload: {
                currentTask = [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull
                                                                                  formData) {
                     [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType
                      ];
                 }
                 progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                     if (success != nil) {
                         success(responseObject);
                     }
                 }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     if (failure != nil) {
                         failure(error);
                     }
                 }];
            }
    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        ZHViewController *vc = (ZHViewController *)[UIViewController currentViewController];
//        
//        if ([vc isKindOfClass:[ZHViewController class]]) {
//            [vc.sessionArr addObject:currentTask];
//        }
//    });
    
    manager = nil;
}

#pragma mark  增加接口上传所需要的参数

+(NSDictionary*)dictionaryByAddingCommonParameters:(NSDictionary*)params{
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:params];
    if( dic )
    {
        if ([dic objectForKey:@"v" ] == nil) {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            if (app_Version != nil) {
                [dic setObject:app_Version forKey:@"versionNumber"];
            }
        }
        if ([dic objectForKey:@"deviceCode" ] == nil) {
            NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            if (adId != nil) {
                [dic setObject:adId forKey:@"deviceCode"];
            }
        }
        if ([dic objectForKey:@"appKey" ] == nil) {
            [dic setObject:AppKey forKey:@"appkey"];
        }
        if ([dic objectForKey:@"type" ] == nil) {
            [dic setObject:@"1" forKey:@"mobileType"];
        }
        if( [AppUserProfile sharedInstance].isLogon)
        {
            if ([AppUserProfile sharedInstance].oauthToken.length >0) {
                [dic setObject:[AppUserProfile sharedInstance].oauthToken forKey:@"token"];
                [dic setObject:[AppUserProfile sharedInstance].userId forKey:@"userId"];
            }
        }
      
    }
    return dic;
}
- (NSDictionary *)dictionaryByAddingCommonParameters:(NSDictionary*)params andPhoneNumber:(NSString *)phone
{
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:params];
    if( dic )
    {
        if ([dic objectForKey:@"v" ] == nil) {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            if (app_Version != nil) {
                [dic setObject:app_Version forKey:@"versionNumber"];
            }
        }
        if ([dic objectForKey:@"deviceCode" ] == nil) {
            NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            if (adId != nil) {
                [dic setObject:adId forKey:@"versionNumber"];
            }
        }
        if ([dic objectForKey:@"appKey" ] == nil) {
            [dic setObject:AppKey forKey:@"appkey"];
        }
        if ([dic objectForKey:@"type" ] == nil) {
            [dic setObject:@"1" forKey:@"mobileType"];
        }
        if( [AppUserProfile sharedInstance].isLogon)
        {
            [dic setObject:[AppUserProfile sharedInstance].oauthToken forKey:@"token"];
            [dic setObject:[AppUserProfile sharedInstance].userId forKey:@"id"];
        }

       
    }
    
    return dic;
}

@end
