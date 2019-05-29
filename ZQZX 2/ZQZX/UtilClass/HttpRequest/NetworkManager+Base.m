//
//  NetworkManager+Base.m
//  ZQZX
//
//  Created by 中企 on 2018/10/18.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "NetworkManager+Base.h"
#import "RequestedURL.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "CommonCrypto/CommonDigest.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonCryptor.h>
@implementation NetworkManager (Base)
+(NSString*)currentTimeStamp
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
    // 时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}
-(NSString*)sginaWithTimeStamp:(NSString*)timeStamp
{
    NSString * tmpStr = [NSString stringWithFormat:@"%@%@",AppSecret,timeStamp];
    tmpStr = [NetworkManager md5WithString:tmpStr];
    tmpStr = [tmpStr stringByAppendingString:AppKey];
    
    tmpStr = [NetworkManager md5WithString:tmpStr];
    tmpStr = [tmpStr uppercaseString];//将所有小写字母转成大写
    
    return tmpStr;
}
+(NSString*)md5WithString:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

- (NSString *)sginaWithTS:(NSString *)ts andPhoneNum:(NSString *)phoneNum
{
    NSString * tmpStr = [NSString stringWithFormat:@"%@%@",AppSecret,ts];
    tmpStr = [NetworkManager md5WithString:tmpStr];
    tmpStr = [tmpStr stringByAppendingString:AppKey];
    tmpStr = [NetworkManager md5WithString:tmpStr];
    tmpStr = [tmpStr stringByAppendingString:phoneNum];
    tmpStr = [NetworkManager md5WithString:tmpStr];
    tmpStr = [tmpStr uppercaseString];//将所有小写字母转成大写
    
    return tmpStr;
}
#pragma mark - validators
+(BOOL)validatePhoneNumber:(NSString*)phoneNumber
{
    if ( phoneNumber.length == 0  || phoneNumber.length != 11 ) return NO;
    NSString *regex = @"^((13[0-9])|(147)|(145)|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    if (!isMatch) {
        return NO;
    }
    return YES;
}
@end
