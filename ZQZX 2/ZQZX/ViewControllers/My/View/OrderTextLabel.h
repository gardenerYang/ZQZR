//
//  OrderTextLabel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderTextLabel : UIView
- (instancetype)initWithType;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *srcLabel;
@end

NS_ASSUME_NONNULL_END
