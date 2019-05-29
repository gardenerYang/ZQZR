//
//  HomeModel.m
//  ZQZX
//
//  Created by 中企 on 2018/10/26.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"inve": [InveItem class],
             @"moments": [MomentsItem class],

             };
}
@end
@implementation InveItem
- (void)setOperation:(NSInteger)operation{
    _operation = operation;
}
@end


@implementation MomentsItem
@end
