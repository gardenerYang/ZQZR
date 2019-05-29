//
//  QAModel.m
//  ZQZX
//
//  Created by yangshuai on 2019/1/18.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "QAModel.h"

@implementation QAModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"investAnswers": [QAQModel class],
             };
}
@end
@implementation QAQModel

@end
