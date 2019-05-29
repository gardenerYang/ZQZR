//
//  GesturePwdManageService.m
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "GesturePwdManageService.h"
#import "AppUserProfile.h"
@implementation GesturePwdManageService
+ (void)setObject:(id)object forKey:(id)key
{
    [[NSUserDefaults standardUserDefaults]setObject:object forKey:key];
}

+ (id)objectForKey:(id)key
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key] ;;
}

+ (void)removeObjectForKey:(id)key
{
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:key];
}


#pragma mark --------------------------

+ (BOOL)isSave
{
    NSString *str = [self objectForKey:KEYCHAIN_KEY];
    if (str && str.length>0 && [str isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    return NO;
}


+ (BOOL)isFirstInput:(NSString *)str
{
    //    NSString *oldStr = [self objectForKey:KEYCHAIN_KEY];
    NSString *oldStr = [self objectForKey:TMEPWD_KEY];
    if (oldStr && oldStr.length>0 && [oldStr isKindOfClass:[NSString class]])
    {
        return NO;
    }
    //    [self setObject:str forKey:KEYCHAIN_KEY];
    [self setObject:str forKey:TMEPWD_KEY];
    return YES;
}



+ (BOOL)isSecondInputRight:(NSString *)str
{
    //    NSString *oldStr = [self objectForKey:KEYCHAIN_KEY];
    NSString *oldStr = [self objectForKey:TMEPWD_KEY];
    if ([oldStr isKindOfClass:[NSNull class]]) {
        return NO;
    }
    else if (!oldStr || oldStr.length<1 || ![oldStr isKindOfClass:[NSString class]]) {
        return NO;
    }
    else if (oldStr.length==str.length  &&  [oldStr isEqualToString:str]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)valideInputStr:(NSString *)str
{
    NSString *oldStr = [self objectForKey:KEYCHAIN_KEY];
    
    if ([oldStr isKindOfClass:[NSNull class]]) {
        return NO;
    }
    else if (!oldStr || oldStr.length<1 || ![oldStr isKindOfClass:[NSString class]]) {
        return NO;
    }
    else if (oldStr.length==str.length  &&  [oldStr isEqualToString:str]) {
        return YES;
    }
    
    return NO;
}

+(void)saveInputPassword:(NSString *)str
{
    [self setObject:str forKey:KEYCHAIN_KEY];
    [self setObject:str forKey:TMEPWD_KEY];
}


+ (void)forgotPsw
{
    [self removeObjectForKey:KEYCHAIN_KEY];
    [self removeObjectForKey:TMEPWD_KEY];
}


+ (void)setPSW:(NSString *)str
{
    [self setObject:str forKey:KEYCHAIN_KEY];
}

+(NSString *)keyChainWithUserID
{
    NSString *key = [AppUserProfile sharedInstance].userId;
    if (key.length > 0) {
        return [NSString stringWithFormat:@"password_%@slider",key];
    }
    else
        return @"password_slider";
}

+(NSString *)temKeyWithUserID
{
    NSString *key = [AppUserProfile sharedInstance].userId;
    if (key.length > 0) {
        return [NSString stringWithFormat:@"temSliderPwd%@",key];
    }
    else
        return @"password_slider";
}

+(NSString *)TouchIDWithUserID
{
    NSString *key =[AppUserProfile sharedInstance].userId;
    
    if (key.length > 0) {
        return [NSString stringWithFormat:@"touchId%@",key];
    }
    else
        return @"touchId";
}
@end
