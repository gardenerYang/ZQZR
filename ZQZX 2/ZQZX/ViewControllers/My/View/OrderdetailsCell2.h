//
//  OrderdetailsCell2.h
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTextLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderdetailsCell2 : UITableViewCell
@property (nonatomic, strong) UIView *BKView;
@property (nonatomic, strong) OrderTextLabel   *car1View;
@property (nonatomic, strong) OrderTextLabel   *car2View;
@property (nonatomic, strong) OrderTextLabel   *carPlace2View;
@property (nonatomic, strong) OrderTextLabel   *moneyView;
@property (nonatomic, strong) OrderTextLabel   *timeView;
@property (nonatomic, strong) OrderTextLabel   *payType;

@end

NS_ASSUME_NONNULL_END
