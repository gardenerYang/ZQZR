//
//  RecordModel.m
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyRecordModel.h"

@implementation MyRecordModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"cList": [MyRecordListModel class],
             };
}
@end
@implementation MyRecordListModel

@end
