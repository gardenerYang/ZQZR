//
//  FinancialManagerView.h
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FinancialManagerView : UIView
@property (nonatomic, strong) UILabel   *titleLb;
@property (nonatomic, strong) UILabel   *nameLb;
@property (nonatomic, strong) UIView   *lineView;

- (instancetype)initWithType;

@end

NS_ASSUME_NONNULL_END
