//
//  QNManage.h
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Qiniu/QiniuSDK.h>
#import "HttpRequest+QN.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNManage : NSObject
+(QNManage*)sharedInstance;
-(QNUploadManager *)upManager;
@property (nonatomic, copy) void (^getImgUrl)(NSString *imgUrl);
/**
 七牛上传图片
 
 @param img img
 @param success success description
 @param failure failure description
 */
- (void)qiuNiu:(UIImage *)img token:(NSString *)token url:(NSString *)url success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure;
@end

NS_ASSUME_NONNULL_END
