//
//  OrderdetailsCell1.h
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTextLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderdetailsCell1 : UITableViewCell
@property (nonatomic, strong) UIView *BKView;
@property (nonatomic, strong) UILabel   *orderNumLb;
@property (nonatomic, strong) UILabel   *titleLb;
@property (nonatomic, strong) UILabel   *tagLb;
@property (nonatomic, strong) OrderTextLabel   *numView;

@property (nonatomic, strong) OrderTextLabel   *moneyView;
@property (nonatomic, strong) OrderTextLabel  *deadlineView;
@property (nonatomic, strong) OrderTextLabel   *timeView;
@property (nonatomic, strong) OrderTextLabel   *stateView;
@property (nonatomic, strong) OrderTextLabel   *nameView;
@property (nonatomic, strong) OrderTextLabel   *phoneiew;

@end

NS_ASSUME_NONNULL_END
