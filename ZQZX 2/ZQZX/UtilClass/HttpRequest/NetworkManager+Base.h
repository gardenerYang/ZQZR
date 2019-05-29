//
//  NetworkManager+Base.h
//  ZQZX
//
//  Created by 中企 on 2018/10/18.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "NetworkManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager (Base)
/**
 * 获取当前时间戳
 *
 * @return 当前时间戳，长整型格式
 */
+(NSString*)currentTimeStamp;
/**
 * 生成接口验证signa字段值
 *
 * @param timeStamp 长整型时间戳
 * @return 生成的singa值
 */
-(NSString*)sginaWithTimeStamp:(NSString*)timeStamp;

/** 生成signa字段值：添加了手机字段*/
-(NSString *)sginaWithTS:(NSString *)ts andPhoneNum:(NSString *)phoneNum;
+(NSString*)md5WithString:(NSString *)str;
/**
 检验是不是手机号

 @param phoneNumber 手机号
 @return bool
 */
+(BOOL)validatePhoneNumber:(NSString*)phoneNumber;
@end

NS_ASSUME_NONNULL_END
