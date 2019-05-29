//
//  DetailsBottomView.h
//  ZQZX
//
//  Created by 中企 on 2018/10/16.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PPNumberButton/PPNumberButton.h>
NS_ASSUME_NONNULL_BEGIN

@interface DetailsBottomView : UIView
@property (nonatomic, strong) UIView   *bottomView;
@property (nonatomic, strong) UIButton      *appointmentBtn;
@property (nonatomic, strong) PPNumberButton      *numberButton;
@property (nonatomic, copy) void            (^appointmentBlock)(void);
@property (nonatomic, assign) CGFloat reservationAmount;//可预约金额

@property (nonatomic, copy) void(^resultBlock)(PPNumberButton *ppBtn,CGFloat number, BOOL increaseStatus/* 是否为加状态*/);
- (instancetype)initWithType;
@end

NS_ASSUME_NONNULL_END
