//
//  PlanTableViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTextLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlanTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *BKView;
@property (nonatomic, strong) UILabel   *titleLb;
@property (nonatomic, strong) UILabel   *periodlab;

@property (nonatomic, strong) OrderTextLabel   *typeView;
@property (nonatomic, strong) OrderTextLabel   *moneyView;
@property (nonatomic, strong) OrderTextLabel   *timeView;

@end

NS_ASSUME_NONNULL_END
