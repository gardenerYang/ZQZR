//
//  MyNavView.h
//  ZQZX
//
//  Created by 中企 on 2018/10/18.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyNavView : UIView
@property (nonatomic, strong) UIView   *navView;
@property (nonatomic, strong) UIImageView   *photoImg;
@property (nonatomic, strong) UIButton   *setupBtn;
@property (nonatomic, strong) UILabel   *nameLb;
@property (nonatomic, copy) void (^tapBtnblock)(void);

- (instancetype)initWithType;

@end

NS_ASSUME_NONNULL_END
