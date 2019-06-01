//
//  ActivityTableViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
/* 动画倒计时 */
#import "HSFTimeDownView.h"
#import "HSFTimeDownConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *BKView;

@property (nonatomic, strong) UIImageView *bgimgView;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) HSFTimeDownConfig *config;
@property (nonatomic, strong) HSFTimeDownView *timeLabel_hsf;
@property (nonatomic, strong) UILabel *srcLb;
-(void)isStatelayout;


@end

NS_ASSUME_NONNULL_END
