//
//  MyOrderTableViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderTableViewCell : UITableViewCell


@property (nonatomic, strong) UIView *BKView;

@property (nonatomic, strong) UILabel   *orderNumLb;
@property (nonatomic, strong) UILabel   *timeLb;
@property (nonatomic, strong) UILabel   *titleLb;
@property (nonatomic, strong) UILabel   *tagLb;
@property (nonatomic, strong) UIImageView   *jianImg;

@property (nonatomic, strong) UILabel   *src1Lb;
@property (nonatomic, strong) UILabel   *moneyLb;

@property (nonatomic, strong) UILabel   *src2Lb;
@property (nonatomic, strong) UILabel   *numLb;

@end

NS_ASSUME_NONNULL_END
