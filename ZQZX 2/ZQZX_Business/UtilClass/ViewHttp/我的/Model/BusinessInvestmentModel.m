//
//  BusinessInvestmentModel.m
//  ZQZX
//
//  Created by 中企 on 2018/11/1.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BusinessInvestmentModel.h"

@implementation BusinessInvestmentModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"cList": [BusinessInvestmentListModel class],
             };
}
@end
@implementation BusinessInvestmentListModel

@end
