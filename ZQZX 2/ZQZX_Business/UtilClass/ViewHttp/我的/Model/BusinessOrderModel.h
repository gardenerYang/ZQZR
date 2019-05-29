//
//  BusinessOrderModel.h
//  ZQZX
//
//  Created by 中企 on 2018/11/2.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"
@class BusinessOrderListModel;
NS_ASSUME_NONNULL_BEGIN

@interface BusinessOrderModel : BaseClass
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , strong) NSArray <BusinessOrderListModel *>              * cList;
@property (nonatomic , assign) NSInteger              pageNum;
@end
@interface BusinessOrderListModel : BaseClass
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * investmentNo;
@property (nonatomic , assign) NSInteger              projectDuration;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              reservationAmount;
@property (nonatomic , copy) NSString              *expectedYield;
@property (nonatomic , assign) NSInteger              addTime;
@property (nonatomic , copy) NSString              *subscribeAmount;
@end
NS_ASSUME_NONNULL_END
