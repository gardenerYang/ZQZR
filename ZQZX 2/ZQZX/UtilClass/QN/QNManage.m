//
//  QNManage.m
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "QNManage.h"
#import "NSError+Util.h"
QNManage *qnManage = nil;
@interface QNManage()
@property(nonatomic,strong)QNUploadManager *upManager;

@end
@implementation QNManage
+ (QNManage*)sharedInstance
{
    if( qnManage == nil ){
        qnManage = [[QNManage alloc] init];
    }
    return qnManage;
}


-(QNUploadManager *)upManager{
    if (!_upManager) {
        _upManager = [[QNUploadManager alloc] init];
    }
    return _upManager;
}
- (void)qiuNiu:(UIImage *)img token:(NSString *)token url:(NSString *)url success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    NSString *key = [NSString stringWithFormat:@"%@.png", [[NSUUID UUID] UUIDString]];
    NSData *data = UIImageJPEGRepresentation(img, 0.75f);
   [_upManager putData:data key:key token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        
        NSString *Keyvalue = [resp objectForKey:@"key"];
        if ((NSNull *)Keyvalue == [NSNull null]) {
            NSError *error = [NSError errorWithCode:info.statusCode msg:@"图片上传失败"];
            
            if (failure) {
                failure(error);
            }
        } else {
            NSLog(@"%@",[NSString stringWithFormat:@"%@%@",url,Keyvalue]);
            //不空
            if (success) {
                success([NSString stringWithFormat:@"%@%@",url,Keyvalue]);
            }
        }
    } option:nil];
}

@end
