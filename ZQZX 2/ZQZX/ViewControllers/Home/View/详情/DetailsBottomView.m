//
//  DetailsBottomView.m
//  ZQZX
//
//  Created by 中企 on 2018/10/16.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "DetailsBottomView.h"

@implementation DetailsBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithType{
    self = [super init];
    
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI {
    self.backgroundColor = [UIColor withHexStr:@"f8f9fa"];
    
    _bottomView = [[UIView alloc]init];
    [self addSubview:_bottomView];
    
    _numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(10, 10, 150, 30)];
    //设置边框颜色
    _numberButton.borderColor = [UIColor grayColor];
    _numberButton.increaseTitle = @"＋";
    _numberButton.decreaseTitle = @"－";
    _numberButton.currentNumber = 0;
//    _numberButton.maxValue = self.reservationAmount;

    __weak typeof(self) weakSelf = self;

    _numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
        NSLog(@"%f",number);
        if (weakSelf.resultBlock) {
            weakSelf.resultBlock(ppBtn, number, increaseStatus);
        }
    };
    
    [_bottomView addSubview:_numberButton];
    
    _appointmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_appointmentBtn setBackgroundColor:kMainColor];
    [_appointmentBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    _appointmentBtn.titleLabel.font = [UIFont s16];
//    _appointmentBtn.layer.masksToBounds = YES;
    _appointmentBtn.layer.cornerRadius = 15;
    _appointmentBtn.layer.shadowOffset = CGSizeMake(1,4);
    _appointmentBtn.layer.shadowOpacity = 0.6;
    _appointmentBtn.layer.shadowColor =  kMainColor.CGColor;
    __weak typeof(self) wf = self;
    [_appointmentBtn addAction:^(UIButton *sender) {
        if (wf.appointmentBlock) {
            wf.appointmentBlock();
        }
    }];
    [_bottomView addSubview:_appointmentBtn];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [_numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.appointmentBtn.mas_left).offset(-20);
    }];
    
    [_appointmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(100);
    }];
    
    
    
}
@end
