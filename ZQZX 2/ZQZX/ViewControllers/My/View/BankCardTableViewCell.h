//
//  BankCardTableViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankCardTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView   *bgImgView;
@property (nonatomic, strong) UIImageView   *photoImgView;
@property (nonatomic, strong) UILabel   *titleLb;
@property (nonatomic, strong) UILabel   *srcLb;
@property (nonatomic, strong) UILabel   *numLb;

@end

NS_ASSUME_NONNULL_END
