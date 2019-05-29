//
//  ExamineCollectionViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExamineCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel       *titleLB;
@property (nonatomic, strong) UILabel       *stateLB;

@property (nonatomic, strong) UIView       *bottomLine;
@property (nonatomic, strong) UIView       *rightLine;
@end

NS_ASSUME_NONNULL_END
