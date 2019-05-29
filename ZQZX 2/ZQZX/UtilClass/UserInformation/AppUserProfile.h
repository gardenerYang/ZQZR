//
//  AppUserProfile.h
//  ZQZX
//
//  Created by 中企 on 2018/10/18.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppUserProfile : NSObject
/**
 *  用户id
 */

@property(nonatomic,copy)NSString*              userId;
/**
 *  用户名
 */
@property(nonatomic,copy)NSString*              userName;
@property(nonatomic,copy)NSString*              username;

/**
 *  登录认证信息
 */
@property(nonatomic,copy)NSString*              oauthToken;
/**
 *  刷新token
 */
@property(nonatomic,copy)NSString*              refresh_token;
/**
 *  生命周期
 */
@property(nonatomic,strong)NSString*              tokenExpiredTime;
/**
 *  手机号码
 */
@property(nonatomic,copy)NSString*              phoneNumber;
/**
 *  邮箱地址
 */
@property(nonatomic,copy)NSString*              emailAddress;
/**
 *  其他数据
 */
@property(nonatomic,strong)NSMutableDictionary* customAttributes;
/**
 *  是否登录
 */
@property(nonatomic,readonly)BOOL               isLogon;
@property(nonatomic,copy)NSString*              idNo;
@property(nonatomic,copy)NSString*              realName;


#if BusinessTag
/**
 是否锁定
 */
@property(nonatomic,readonly)BOOL               isLock;
/**
 理财师推荐码
 */
@property(nonatomic,copy)NSString*              referralCode;

#else

#endif


+(AppUserProfile*)sharedInstance;

-(void)cleanUp;
-(BOOL)save;
-(BOOL)load;
-(void)updateTokenExpiredTime:(NSTimeInterval)life;
-(BOOL)saveUserInfoWithModel:(LoginModel *)model;
-(BOOL)saveidNo:(NSString *)idNo;
-(BOOL)saveidrealName:(NSString *)realName;

@end

NS_ASSUME_NONNULL_END
