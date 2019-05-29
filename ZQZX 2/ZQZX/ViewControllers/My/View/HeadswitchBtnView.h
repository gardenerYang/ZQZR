//
//  HeadswitchBtnView.h
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeadswitchBtnView : UIView
- (instancetype)initWithType;

@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)NSString *leftTitle;
@property(nonatomic,strong)NSString *rightTitle;
@property (nonatomic, copy) void (^tapLeftBtnblock)(void);
@property (nonatomic, copy) void (^tapRightBtnblock)(void);


@end

NS_ASSUME_NONNULL_END
