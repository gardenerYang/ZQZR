//
//  DetailsHeadView.h
//  ZQZX
//
//  Created by 中企 on 2018/10/16.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadTextLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsHeadView : UIView
@property (nonatomic, strong) UIView   *headView;
@property (nonatomic, strong)  UIImageView  *headImgView;
@property (nonatomic, strong)  HeadTextLabel  *dayView;
@property (nonatomic, strong)  HeadTextLabel  *moneyView;
@property (nonatomic, strong)  HeadTextLabel  *numView;
@property (nonatomic, strong)  HeadTextLabel  *num1View;

@property (nonatomic, strong)  UILabel  *titleLb;
@property (nonatomic, strong)  UILabel  *srcLb;
@property (nonatomic, strong)  UIImageView  *raiseImg;


@end

NS_ASSUME_NONNULL_END
