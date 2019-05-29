//
//  BusinessOrderdetailsModel.h
//  ZQZX
//
//  Created by 中企 on 2018/11/2.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface BusinessOrderdetailsModel : BaseClass
@property (nonatomic , copy) NSString              *rateYear;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * investmentNo;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * remitBankNo;
@property (nonatomic , assign) NSInteger              payTime;
@property (nonatomic , copy) NSString              * repaymentBankNo;
@property (nonatomic , copy) NSString             * subscribeAmount;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , copy) NSString              * bank;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , assign) NSInteger              actualAmount;
@property (nonatomic , copy) NSString              * certificateUrl;
@property (nonatomic , assign) NSInteger              addTime;
@property (nonatomic , assign) NSInteger              reservationAmount;
@property (nonatomic,  copy) NSString * projectDuration;
@property (nonatomic,  copy) NSString * settlementInterest;


@end

NS_ASSUME_NONNULL_END
