//
//  ProductListCell.h
//  ZQZX
//
//  Created by yangshuai on 2019/6/1.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"
#import "HomeTimeLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageV;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong) CListItem * model;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet HomeTimeLabel *timeMoudle;
@property (weak, nonatomic) IBOutlet UILabel *prodeuctName;
@property (weak, nonatomic) IBOutlet UILabel *productTitle;

@end

NS_ASSUME_NONNULL_END
