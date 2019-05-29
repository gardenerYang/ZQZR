//
//  BusinessOrderModel.m
//  ZQZX
//
//  Created by 中企 on 2018/11/2.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BusinessOrderModel.h"

@implementation BusinessOrderModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"cList": [BusinessOrderListModel class],
             };
}
@end
@implementation BusinessOrderListModel

@end

