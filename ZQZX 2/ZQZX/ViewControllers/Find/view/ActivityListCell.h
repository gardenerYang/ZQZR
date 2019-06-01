//
//  ActivityListCell.h
//  ZQZX
//
//  Created by yangshuai on 2019/6/1.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiveModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ActivityListCell : UITableViewCell
@property (nonatomic,strong)ActiveModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *activityImage;
@property (weak, nonatomic) IBOutlet UIImageView *activityState;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *timeView;

@end

NS_ASSUME_NONNULL_END
