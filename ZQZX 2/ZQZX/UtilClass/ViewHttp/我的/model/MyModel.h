//
//  MyModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/26.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyModel : BaseClass
@property (nonatomic , copy) NSString              *amountTotalInvestment;
@property (nonatomic , copy) NSString              * lcsCity;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , assign) NSInteger              realNameStatus;
@property (nonatomic , copy) NSString              *incomeCollected;
@property (nonatomic , copy) NSString              * idNo;
@property (nonatomic , copy) NSString              * lcsPhone;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , copy) NSString             * incomeCollecting;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , assign) NSInteger              bankStatus;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * referralCode;
@property (nonatomic , copy) NSString              * lcsRealName;
@property (nonatomic , copy) NSString              * contactAddress;
@property (nonatomic , copy) NSString              * headPortraitUrl;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic,  copy) NSString * content;
@property (nonatomic,  copy) NSString * option;
@property (nonatomic,  copy) NSString * q_code;
@property (nonatomic,  copy) NSString * isQuestionDone;
@property (nonatomic,strong) NSNumber * investorConfirm;

@end

NS_ASSUME_NONNULL_END
