//
//  ProductDetailsModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/29.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"
@class RecordModel;
NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailsModel : BaseClass
@property (nonatomic , assign) NSInteger              proTotalAmount;
@property (nonatomic , copy) NSString              * increasingAmountStr;
@property (nonatomic , assign) NSInteger              earningWay;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              reservationAmount;
@property (nonatomic , assign) CGFloat              expectedYield;
@property (nonatomic , assign) NSInteger              increasingAmount;
@property (nonatomic , assign) NSInteger              projectDuration;
@property (nonatomic , assign) NSInteger              purchaseAmount;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , assign) NSInteger              platformRateYear;
@property (nonatomic , assign) CGFloat              standingInterest;
@property (nonatomic ,   copy) NSString*              strategyNumber;
@property (nonatomic,  copy) NSString * feature;
@property (nonatomic,  copy) NSString * ext;
@property (nonatomic,  copy) NSString * id;

@end

@interface RecordListModel :NSObject
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , strong) NSArray <RecordModel *>              * cList;
@property (nonatomic , assign) NSInteger              pageNum;

@end
@interface RecordModel : BaseClass
@property (nonatomic , assign) NSInteger              productId;
@property (nonatomic , assign) NSInteger              addTime;
@property (nonatomic , assign) NSInteger              fpId;
@property (nonatomic , copy) NSString              * fpName;
@property (nonatomic , assign) NSInteger              reservationAmount;
@property (nonatomic , assign) NSInteger              InvestmentId;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , assign) NSInteger              userId;
@end
NS_ASSUME_NONNULL_END
