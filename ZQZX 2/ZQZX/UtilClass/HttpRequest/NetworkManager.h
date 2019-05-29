//
//  ASNetworkManager.h
//  Assistant
//
//  Created by 少爷 on 2017/5/24.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

@interface UploadParam : NSObject
///图片的二进制数据
@property (nonatomic, strong, nonnull) NSData *data;///服务器对应的参数名称
@property (nonatomic, copy, nonnull) NSString *name;///文件的名称(上传到服务器后，服务器保存的文件名)
@property (nonatomic, copy, nonnull) NSString *filename;///文件的MIME类型(image/png,image/jpg等)
@property (nonatomic, copy, nonnull) NSString *mimeType;

@end

///网络请求类型
typedef NS_ENUM (NSUInteger, HttpRequestType) {
    //    get请求
    HttpRequestTypeGet = 0 ,
    //    post请求
    HttpRequestTypePost,
    //    Upload上传
    HttpRequestTypeUpload,
};

@interface NetworkManager : NSObject

//+ (void)cancelRequestWithVC:(ZHViewController *_Nullable)vc;

/**发送get请求
 *
 *  @param URLString 请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */

+ ( void)getWithURLString:(nonnull NSString *)URLString
               parameters:( nullable id)parameters
                  success:(nonnull void (^)(id _Nonnull responseObject))success
                  failure:(nonnull void (^)(NSError *_Nonnull error))failure;

/**发送post请求
 *
 *  @param URLString 请求的网址字符串
 *  @param parameters 请求的参数
  *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */

+ (void)postWithURLString:(nonnull NSString *)URLString
               parameters:(nonnull id)parameters
                  success:(nonnull void (^)(id _Nonnull responseObject))success
                  failure:(nonnull void (^)(NSError *_Nonnull error))failure;
/**上传图片
 *  @param URLString 上传图片的网址字符串
 *  @param parameters 上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success 上传成功的回调
 *  @param failure 上传失败的回调
 */

+ (void)uploadWithURLString:(NSString * _Nonnull)URLString
                 parameters:( id _Nonnull)parameters
                uploadParam:(UploadParam * _Nonnull)uploadParam
                   progress:(nullable void (^)(NSProgress *_Nonnull uploadProgress))uploadProgress
                    success:(nonnull void (^)(id _Nonnull responseObject))success
                    failure:(nonnull void (^)( NSError *_Nonnull error ))failure;

/** 发送网络请求
 @param URLString 请求的网址字符串
 @param parameters 请求的参数
 @param type 请求的类型
 @param uploadParam 上传参数
 @param uploadProgress 上传进度
 @param success 上传成功的回调
 @param failure 上传失败的回调
  */

+ (void)requestWithURLString:(nonnull NSString *)URLString
                  parameters:(nonnull id)parameters
                        type:(HttpRequestType)type
                 uploadParam:(UploadParam * _Nullable)uploadParam
                    progress:(nullable void (^)(NSProgress *_Nonnull ))uploadProgress
                     success:(nonnull void (^)(id _Nonnull responseObject))success
                     failure:(nonnull void (^)(NSError * _Nonnull error))failure;

@end
