//
//  RemindListCell.h
//  ZQZX
//
//  Created by yangshuai on 2019/4/19.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemindListSelectView.h"
#import "HomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RemindListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (nonatomic,strong) RemindListSelectView * selectView;
@property (nonatomic,strong) InveItem * model;
@property (nonatomic,strong) void (^ selectOption) (NSInteger option);

@end

NS_ASSUME_NONNULL_END
