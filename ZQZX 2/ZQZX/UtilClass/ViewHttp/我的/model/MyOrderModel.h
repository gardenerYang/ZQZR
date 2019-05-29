//
//  MyOrderModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"
@class MyOrderListModel;
NS_ASSUME_NONNULL_BEGIN

@interface MyOrderModel : BaseClass
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , strong) NSArray <MyOrderListModel *>     * cList;
@property (nonatomic , assign) NSInteger              pageNum;
@end

@interface MyOrderListModel : BaseClass
@property (nonatomic , copy) NSString              *subscribeAmount;
@property (nonatomic , copy) NSString              *rateYear;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , assign) NSInteger              addTime;
@property (nonatomic , copy) NSString              * investmentNo;

@end
NS_ASSUME_NONNULL_END
