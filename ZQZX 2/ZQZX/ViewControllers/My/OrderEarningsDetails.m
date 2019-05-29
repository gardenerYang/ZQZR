//
//  OrderEarningsDetails.m
//  ZQZX
//
//  Created by yangshuai on 2019/1/21.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "OrderEarningsDetails.h"

@interface OrderEarningsDetails ()

@end

@implementation OrderEarningsDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"收益详情"];
    self.view.backgroundColor = kTabBGColor;

    _cell1.text = [NSString stringWithFormat:@"%.2f",self.model.standGuardInterest?:0];
    _cell2.text = [NSString stringWithFormat:@"%.2f",self.model.productInterest];
    _cell3.text = [NSString stringWithFormat:@"%.2f",self.model.platformInterest];
    _cell4.text = [NSString stringWithFormat:@"%.2f",self.model.settlementInterest];

}



@end
