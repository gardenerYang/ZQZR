//
//  InvestmentManagementCell.h
//  ZQZX_Business
//
//  Created by 中企 on 2018/10/23.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvestmentManagementCell : UITableViewCell
@property (nonatomic, strong) UIView       *BKView;
@property (nonatomic, strong) UIImageView       *imgView;
//@property (nonatomic, strong) UIView       *lineView;
@property (nonatomic, strong) UIView       *line1View;
@property (nonatomic, strong) UILabel       *nameLb;
@property (nonatomic, strong) UILabel       *money1Lb;
@property (nonatomic, strong) UILabel       *money2Lb;
@property (nonatomic, strong) UILabel       *money3Lb;

@end

NS_ASSUME_NONNULL_END
