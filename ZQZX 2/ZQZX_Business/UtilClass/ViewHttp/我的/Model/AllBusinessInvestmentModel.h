//
//  AllBusinessInvestmentModel.h
//  ZQZX
//
//  Created by 中企 on 2018/11/1.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"
@class YqyItem,DqyItem,DqyTotal,YqyTotal;
NS_ASSUME_NONNULL_BEGIN

@interface AllBusinessInvestmentModel : BaseClass
@property (nonatomic , strong) NSArray <YqyItem *>              * yqy;
@property (nonatomic , strong) NSArray <DqyItem *>              * dqy;
@property (nonatomic , strong) DqyTotal              * dqyTotal;
@property (nonatomic , strong) YqyTotal              * yqyTotal;
@end
@interface YqyItem :NSObject
@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              actualAmount;
@property (nonatomic , assign) NSInteger              month;

@end


@interface DqyItem :NSObject
@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              actualAmount;
@property (nonatomic , assign) NSInteger              month;
@end
@interface DqyTotal :NSObject
@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              actualAmount;

@end


@interface YqyTotal :NSObject
@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              actualAmount;

@end
NS_ASSUME_NONNULL_END
