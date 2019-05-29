//
//  HomeTableViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/15.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTimeLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *BKView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIView *linevView;
@property (nonatomic, strong) UILabel *numTitleLb;
@property (nonatomic, strong) UILabel *srcTitleLb;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *stateLb;
@property (nonatomic, strong) UIImageView *interestsLb;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *dayLb;
@property (nonatomic, strong) UILabel *moneyLb;
@property (nonatomic, strong) HomeTimeLabel *timeLb;
@property (nonatomic, copy) void            (^morebtnClickBlock)(void);

@property (nonatomic, strong) UILabel *timeTitle;

@end

NS_ASSUME_NONNULL_END
