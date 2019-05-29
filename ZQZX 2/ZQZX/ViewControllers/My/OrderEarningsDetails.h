//
//  OrderEarningsDetails.h
//  ZQZX
//
//  Created by yangshuai on 2019/1/21.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"
#import "PlanDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderEarningsDetails : ZHViewController
@property (weak, nonatomic) IBOutlet UILabel *cell1;
@property (weak, nonatomic) IBOutlet UILabel *cell2;
@property (weak, nonatomic) IBOutlet UILabel *cell3;
@property (weak, nonatomic) IBOutlet UILabel *cell4;
@property (nonatomic,strong)PlanDetailsModel * model;
@end

NS_ASSUME_NONNULL_END
