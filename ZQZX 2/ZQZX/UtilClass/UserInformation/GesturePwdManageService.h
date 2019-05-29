//
//  GesturePwdManageService.h
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GesturePwdHead.h"
NS_ASSUME_NONNULL_BEGIN

@interface GesturePwdManageService : NSObject
/****** 是否是第一次输入 ******/
+ (BOOL)isFirstInput:(NSString *)str;

/****** 判断第二次输入 ******/
+ (BOOL)isSecondInputRight:(NSString *)str;

+ (BOOL)valideInputStr:(NSString *)str;

+(void)saveInputPassword:(NSString *)str;

/****** 忘记密码 ******/
+ (void)forgotPsw;

/****** 设置密码 ******/
+ (void)setPSW:(NSString *)str;

/***** 是否有保存记录 ******/
+ (BOOL)isSave;


+ (void)setObject:(id)object forKey:(id)key;
+ (id)objectForKey:(id)key;
+ (void)removeObjectForKey:(id)key;

+(NSString *)keyChainWithUserID;

/**
 *  临时性的KEY
 *
 *  @return key
 */
+(NSString *)temKeyWithUserID;

+(NSString *)TouchIDWithUserID;
@end

NS_ASSUME_NONNULL_END
