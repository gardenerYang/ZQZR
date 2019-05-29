//
//  PlanDetailsModel.h
//  ZQZX
//
//  Created by 中企 on 2018/11/5.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlanDetailsModel : BaseClass
@property (nonatomic , copy) NSString              *rateYear;
@property (nonatomic , copy) NSString              * borrowName;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * repaidCapital;
@property (nonatomic , copy) NSString              * repaidInterest;
@property (nonatomic , assign) NSInteger              addTime;
@property (nonatomic , assign) NSInteger              actualAmount;
@property (nonatomic , copy) NSString              * contractId;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , assign) NSInteger               broId;
@property (nonatomic,  assign) CGFloat  platformInterest;//加息收益
@property (nonatomic,  assign) CGFloat  standGuardInterest;//募集期收益
@property (nonatomic,  assign) CGFloat  productInterest;//预期年化收益
@property (nonatomic,  assign) CGFloat  settlementInterest;//预期年化收益
@property (nonatomic,  assign) CGFloat  interest;
@property (nonatomic,  assign) CGFloat  repaymentAmount;
@property (nonatomic,  assign) CGFloat  projectEndTime;
@property (nonatomic,  assign) CGFloat  repaymentTime;
@property (nonatomic,  assign) CGFloat  carryInterestTime;
@property (nonatomic , copy) NSString              * payTime;

@property (nonatomic,  assign) NSInteger  iteration;
@property (nonatomic,  assign) NSInteger  flag;
@property (nonatomic,  assign) NSInteger  period;
@property (nonatomic , copy) NSString              * investmentNo;



@end

NS_ASSUME_NONNULL_END
