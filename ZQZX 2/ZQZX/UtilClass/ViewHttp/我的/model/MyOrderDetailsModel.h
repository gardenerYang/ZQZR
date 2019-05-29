//
//  MyOrderDetailsModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/31.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderDetailsModel : BaseClass
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , copy) NSString              *rateYear;
@property (nonatomic , copy) NSString              *subscribeAmount;
@property (nonatomic , copy) NSString              * addTime;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * remitBankNo;
@property (nonatomic , copy) NSString              * repaymentBankNo;
@property (nonatomic , copy) NSString              * bank;
@property (nonatomic , assign) NSInteger              actualAmount;
@property (nonatomic , copy) NSString              *payTime;
@property (nonatomic , strong) NSArray <NSString *>              * certificateUrl;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * investmentNo;
@property (nonatomic , assign) NSInteger               productId;
@property (nonatomic,  copy) NSString * projectDuration;
@property (nonatomic,  assign) CGFloat  platformInterest;//加息收益
@property (nonatomic,  assign) CGFloat  standGuardInterest;//募集期收益
@property (nonatomic,  assign) CGFloat  productInterest;//预期年化收益
@end

NS_ASSUME_NONNULL_END
