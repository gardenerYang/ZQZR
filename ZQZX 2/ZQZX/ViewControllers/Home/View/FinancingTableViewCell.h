//
//  FinancingTableViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/15.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZJJTimeCountDown/ZJJTimeCountDownLabel.h>
#import "HomeTimeLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FinancingTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *BKView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *stateLb;
@property (nonatomic, strong) UILabel *numLb;
@property (nonatomic, strong) UILabel *srcnumLb;
@property (nonatomic, strong) UILabel *dayLb;
@property (nonatomic, strong) UILabel *srcdayLb;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UILabel *progressLabel;

@property (nonatomic, strong) UILabel *moneyLb;
@property (nonatomic, strong) UILabel *srcmoneyLb;
@property (nonatomic, strong) UIImageView *interestsLb;
@property (nonatomic, strong) HomeTimeLabel *timeLb;

@end

NS_ASSUME_NONNULL_END
