//
//  HeadTextLabel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/16.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeadTextLabel : UIView
- (instancetype)initWithType;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *srcLabel;
@property (nonatomic, strong) UIView *lineView;

@end

NS_ASSUME_NONNULL_END
