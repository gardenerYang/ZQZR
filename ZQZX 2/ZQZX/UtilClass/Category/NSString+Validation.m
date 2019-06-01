//
//  NSString+Validation.m
//  LoginViewDemo
//
//  Created by erongdu_cxk on 16/3/14.
//  Copyright © 2016年 erongdu. All rights reserved.
//

#import "NSString+Validation.h"

//手机号码验证13开头
#define kValidationPhone @"^((1[34578][0-9])|(14[57])|(17[0678]))\\d{8}$"
//邮箱验证
#define kValidationMail @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
//身份证验证
#define kValidationIDCard @"^\\d{8,18}|[0-9x]{8,18}|[0-9X]{8,18}?$"
//IP地址验证
#define kValidationIP @"((?:(?:25[0-5]|2[0-4]\\d|[01]?\\d?\\d)\\.){3}(?:25[0-5]|2[0-4]\\d|[01]?\\d?\\d))"
//日期中的月验证(01~09和1~12)
#define kValidationMonth @"^(0?[1-9]|1[0-2])$"
//日期中的日验证(01~09和1~31)
#define kValidationDay @"^((0?[1-9])|((1|2)[0-9])|30|31)$"
//密码验证
#define kValidationPassword @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"
//用户名验证（包含数字加字母）
#define kValidationUserName @"^[a-zA-Z0-9\u4e00-\u9fa5]+$"
//银行卡简单验证 16位和19位
#define kValidationBankCard @"^\\d{16}|\\d{19}$"
//验证码纯数字6位
#define kValidationPhoneCode @"^\\d{6}"
//中文验证
#define kValidationChinese @"^[\u4E00-\u9FA5]*$"
//验证字母和数字
#define kValidationLetterOrNumber @"^[a-zA-Z0-9]{0,}$"
//验证纯数字
#define kValidationTypeNumber @"^[0-9]*$"

@implementation NSString (Validation)

- (BOOL)validationType:(ValidationType)validationType
{
    return [self validationExpression:[self expressionByValidationType:validationType]];
}

- (BOOL)validationExpression:(NSString *)expression
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",expression];
    return [predicate evaluateWithObject:self];
}


- (BOOL)isPrueInt
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    int intVal;
    return [scanner scanInt:&intVal] && [scanner isAtEnd];
}

- (BOOL)isPrueFloat
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    float floatVal;
    return [scanner scanFloat:&floatVal] && [scanner isAtEnd];
}

- (BOOL)isPrueIntOrFloat
{
    return [self isPrueFloat]||[self isPrueInt];
}

/**
 *  根据类型返回对应的正则表达式
 *
 *  @param type 待验证的正则表达式
 *
 *  @return 正则表达式
 */
- (NSString *)expressionByValidationType:(ValidationType)type
{
    NSString *str;
    switch (type) {
        case ValidationTypePhone:
            str = kValidationPhone;
            break;
        case ValidationTypeMail:
            str = kValidationMail;
            break;
        case ValidationTypeIDCard:
            str = kValidationIDCard;
            break;
        case ValidationTypeIP:
            str = kValidationIP;
            break;
        case ValidationTypeMonth:
            str = kValidationMonth;
            break;
        case ValidationTypeDay:
            str = kValidationDay;
            break;
        case ValidationTypePassword:
            str = kValidationPassword;
            break;
        case ValidationTypeUserName:
            str = kValidationUserName;
            break;
        case ValidationTypeBankCard:
            str = kValidationBankCard;
            break;
        case ValidationTypePhoneCode:
            str = kValidationPhoneCode;
            break;
        case ValidationTypeChinese:
            str = kValidationChinese;
            break;
        case ValidationTypeLetterOrNumber:
            str = kValidationLetterOrNumber;
            break;
        case ValidationTypeNumber:
            str = kValidationTypeNumber;
            break;
        default:
            str = @"";
            break;
    }
    return str;
}
+(NSString *)stringFormatNumberWithFloat:(double)floatValue
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%.2lf",floatValue];
    NSUInteger start = str.length - 4;
    return [NSString formatNumberWithString:str startIndex:start];
}
+ (NSString *)formatNumberWithString:(NSMutableString *)str startIndex:(NSUInteger)start
{
    int k = 0;
    for (NSUInteger i = start; i > 0; i--)
    {
        k++;
        //每隔3个插入一个‘,’号
        if (k == 3) {
            [str insertString:@"," atIndex:i];
            k = 0;
        }
    }
    return [str copy];
}
+(NSString *)stringFormatPercentNumberWithFloat:(double)floatValue
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%.2lf%%",floatValue];
    NSUInteger start = str.length - 4;
    return [NSString formatNumberWithString:str startIndex:start];
}
+ (NSString *)replaceStringWithIDCardString:(NSString*)string{
    if (string.length>=15) {
        NSRange range = NSMakeRange(3, 1);
        for (NSInteger i = 0; i < 12; i++) {
            string = [string stringByReplacingCharactersInRange:range withString:@"*"];
            range.location++;
        }
    }
    return string;
}
- (NSString *)toJSONString {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
        return string;
}
/**
 比较两个版本号的大小
 
 @param v1 第一个版本号
 @param v2 第二个版本号
 @return 版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
 */
+ (NSInteger)compareVersion:(NSString *)v1 to:(NSString *)v2 {
    // 都为空，相等，返回0
    if (!v1 && !v2) {
        return 0;
    }
    
    // v1为空，v2不为空，返回-1
    if (!v1 && v2) {
        return -1;
    }
    
    // v2为空，v1不为空，返回1
    if (v1 && !v2) {
        return 1;
    }
    
    // 获取版本号字段
    NSArray *v1Array = [v1 componentsSeparatedByString:@"."];
    NSArray *v2Array = [v2 componentsSeparatedByString:@"."];
    // 取字段最少的，进行循环比较
    NSInteger smallCount = (v1Array.count > v2Array.count) ? v2Array.count : v1Array.count;
    
    for (int i = 0; i < smallCount; i++) {
        NSInteger value1 = [[v1Array objectAtIndex:i] integerValue];
        NSInteger value2 = [[v2Array objectAtIndex:i] integerValue];
        if (value1 > value2) {
            // v1版本字段大于v2版本字段，返回1
            return 1;
        } else if (value1 < value2) {
            // v2版本字段大于v1版本字段，返回-1
            return -1;
        }
        
        // 版本相等，继续循环。
    }
    
    // 版本可比较字段相等，则字段多的版本高于字段少的版本。
    if (v1Array.count > v2Array.count) {
        return 1;
    } else if (v1Array.count < v2Array.count) {
        return -1;
    } else {
        return 0;
    }
    
    return 0;
}
+ (NSString *)replaceStringWithString:(NSString*)string Asterisk:(NSInteger)startLocation length:(NSInteger)length {
    for (NSInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(startLocation, 1);
        string = [string stringByReplacingCharactersInRange:range withString:@"*"]; startLocation ++;
    }
    return string;
}
@end
