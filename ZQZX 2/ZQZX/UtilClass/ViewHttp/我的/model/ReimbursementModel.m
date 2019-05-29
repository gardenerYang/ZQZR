//
//  ReimbursementModel.m
//  ZQZX
//
//  Created by 中企 on 2018/10/31.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ReimbursementModel.h"

@implementation ReimbursementModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"cList": [ReimbursementListModel class],
             };
}
@end
@implementation ReimbursementListModel

@end

