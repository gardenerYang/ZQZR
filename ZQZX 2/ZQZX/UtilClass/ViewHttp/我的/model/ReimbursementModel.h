//
//  ReimbursementModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/31.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"
@class ReimbursementListModel;
NS_ASSUME_NONNULL_BEGIN

@interface ReimbursementModel : BaseClass
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , strong) NSArray <ReimbursementListModel *>              * cList;
@property (nonatomic , assign) NSInteger              pageNum;
@end
@interface ReimbursementListModel : BaseClass
@property (nonatomic , copy) NSString              * borrowName;
@property (nonatomic , copy) NSString              * priAndInt;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , assign) NSInteger              repTime;
@property (nonatomic , assign) NSInteger              period;


@end
NS_ASSUME_NONNULL_END
