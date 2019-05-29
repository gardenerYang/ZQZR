//
//  ActivityAlertView.h
//  ZQZX
//
//  Created by yangshuai on 2019/4/18.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ActivityAlertView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UIButton *funcBtn;
@property(nonatomic,strong)PlanDetailsModel *model;

@end

NS_ASSUME_NONNULL_END
