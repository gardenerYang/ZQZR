//
//  DetailsTableViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/16.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *BKView;

@property (nonatomic, strong) UIImageView      *icon1;
@property (nonatomic, strong) UILabel      *titleLb1;
@property (nonatomic, strong) UIImageView      *icon2;
@property (nonatomic, strong) UILabel      *titleLb2;

@end

NS_ASSUME_NONNULL_END
