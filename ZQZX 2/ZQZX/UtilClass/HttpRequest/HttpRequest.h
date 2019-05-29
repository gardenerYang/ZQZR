//
//  ASHttpRequest.h
//  Assistant
//
//  Created by 少爷 on 2017/5/24.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
//#import "NSError+Util.h"
#import "NetworkManager.h"
#import "HttpResponse.h"
@interface HttpRequest : NSObject
/**发送get请求
 *
 *  @param relativeUrl 请求的网址字符串
 *  @param param 请求的参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)get:(NSString *)relativeUrl param:(id)param success:(void (^)(HttpResponse *data ,NSString *message ))success failure:(void (^)(NSError *error))failure;
/**发送post请求
 *
 *  @param relativeUrl 请求的网址字符串
 *  @param param 请求的参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)post:(NSString *)relativeUrl param:(id)param success:(void (^)(HttpResponse *data ,NSString *message ))success failure:(void (^)(NSError *error))failure;
/**发送post请求 list
 *
 *  @param relativeUrl 请求的网址字符串
 *  @param param 请求的参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)postForList:(NSString *)relativeUrl param:(id)param success:(void (^)(HttpListResponse *data ,NSString *message ))success failure:(void (^)(NSError *error))failure;

@end
