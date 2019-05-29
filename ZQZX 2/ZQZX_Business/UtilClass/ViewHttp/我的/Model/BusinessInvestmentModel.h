//
//  BusinessInvestmentModel.h
//  ZQZX
//
//  Created by 中企 on 2018/11/1.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN
@class BusinessInvestmentListModel;
@interface BusinessInvestmentModel : BaseClass
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , strong) NSArray <BusinessInvestmentListModel *>              * cList;
@property (nonatomic , assign) NSInteger              pageNum;
@end
@interface BusinessInvestmentListModel : BaseClass
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              dqy ;
@property (nonatomic , assign) NSInteger              yqy   ;
@property (nonatomic , assign) NSInteger              incomeAmount   ;
@property (nonatomic , strong) NSString             * realName         ;
@property (nonatomic , strong) NSString             * headPortraitUrl           ;

@end
NS_ASSUME_NONNULL_END
