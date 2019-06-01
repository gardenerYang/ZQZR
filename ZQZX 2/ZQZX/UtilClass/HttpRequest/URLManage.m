//
//  URLManage.m
//  baianlicai
//
//  Created by 张豪 on 2018/8/13.
//  Copyright © 2018年 Yosef Lin. All rights reserved.
//

#import "URLManage.h"
@implementation URLManage
+ (NSString *)getCurrentBaseUrl{
#if BusinessTag
    return @"http://39.105.24.235:8082";//测试
//    return @"http://store.zqbill.com";//正式

#else
  return @"http://39.105.24.235:8081";
//    return @"http://10.16.8.46:8080";//测试
//    return @"http://clinet.zqbill.com";//正式
#endif
    
/*#if DEBUG
    return @"http://10.16.8.66:8080";
#else
    if ([URLManage judgeTimeByStartAndEnd]) {//哪一个时间段使用
        return @"";
    }
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version=[infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSArray *versionArr=[version componentsSeparatedByString:@"."];
    NSInteger twoNum = [[versionArr objectAtIndex:1] integerValue];
    switch (twoNum % 4) {
        case 0:
            return @"";
            break;
            
        case 1:
            return @"";
            break;
            
        case 2:
            return @"";
            break;
            
        case 3:
            return @"";
            break;
            
        default:
            return nil;
            break;
    }
    
#endif*/
}
+(BOOL)judgeTimeByStartAndEnd
{
    //获取当前时间
    NSDate *today = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: today];
    NSDate *localeDate = [today  dateByAddingTimeInterval: interval];
    //start end 格式 "2016-05-18 9:00"
    NSDate *start = [self dateFromString:@"2017-10-31 11:00"];
    NSDate *expire = [self dateFromString:@"2017-10-31 19:00"];
    if ([localeDate compare:start] == NSOrderedDescending && [localeDate compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

+ (NSDate*)dateFromString:(NSString*)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: destDate];
    NSDate *localeDate = [destDate  dateByAddingTimeInterval: interval];
    return localeDate;
}

+(NSString*)urlWithAPI:(NSString*)URLString
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", [self getCurrentBaseUrl], URLString];
    return urlStr;
}
@end
