//
//  MyOrderModel.m
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyOrderModel.h"

@implementation MyOrderModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"cList": [MyOrderListModel class],
             };
}
@end
@implementation MyOrderListModel

@end

