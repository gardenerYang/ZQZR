//
//  ActivityAlertView.m
//  ZQZX
//
//  Created by yangshuai on 2019/4/18.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "ActivityAlertView.h"

@implementation ActivityAlertView

- (void)setModel:(PlanDetailsModel *)model{
    if (model.flag==0) {
        self.title.text = @"续投确认";
        [self.funcBtn setTitle:@"确认续投" forState:(UIControlStateNormal)];
    }else{
        self.title.text = @"赎回确认";
        [self.funcBtn setTitle:@"确认赎回" forState:(UIControlStateNormal)];
    }
    self.name.text = model.borrowName;
    self.orderNumber.text = [NSString stringWithFormat:@"订单号: %@",model.investmentNo];
    self.money.text = [NSString stringWithFormat:@"金额: %ld元",model.actualAmount];
    
}

@end
