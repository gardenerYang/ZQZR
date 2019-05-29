//
//  StatisticsModel.h
//  ZQZX
//
//  Created by 中企 on 2018/11/1.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"
@class Yqy,Dqy,YqyMonth,DqyMonth;
NS_ASSUME_NONNULL_BEGIN

@interface StatisticsModel : BaseClass
@property (nonatomic , strong) Yqy              * yqy;
@property (nonatomic , strong) Dqy              * dqy;
@property (nonatomic , strong) YqyMonth              * yqyMonth;
@property (nonatomic , strong) DqyMonth              * dqyMonth;
@end
@interface Yqy :NSObject
@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              actualAmount;

@end


@interface Dqy :NSObject
@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              actualAmount;

@end


@interface YqyMonth :NSObject
@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              actualAmount;

@end


@interface DqyMonth :NSObject
@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              actualAmount;

@end

NS_ASSUME_NONNULL_END
