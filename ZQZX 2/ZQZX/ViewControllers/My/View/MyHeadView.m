//
//  MyHeadView.m
//  ZQZX
//
//  Created by 中企 on 2018/10/18.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyHeadView.h"

@implementation MyHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI {
    

    _bgImgView = [[UIImageView alloc]init];
    _bgImgView.image = [UIImage imageNamed:@"my_head"];
    _bgImgView.layer.masksToBounds= YES;
    _bgImgView.layer.cornerRadius = 5;
    [self addSubview:_bgImgView];
    
    
    _srcLb=[[UILabel alloc]init];
    _srcLb.font = [UIFont s16];
    _srcLb.textColor=[UIColor whiteColor];
    _srcLb.textAlignment=NSTextAlignmentCenter;
    _srcLb.text = @"总投资金额 (元)";
    [_bgImgView addSubview:_srcLb];
    
    _moneyLb=[[UILabel alloc]init];
    _moneyLb.font = [UIFont boldSystemFontOfSize:30];
    _moneyLb.textColor=[UIColor whiteColor];
    _moneyLb.textAlignment=NSTextAlignmentCenter;
    [_bgImgView addSubview:_moneyLb];
    

    
    _src1Lb=[[UILabel alloc]init];
    _src1Lb.font = [UIFont s12];
    _src1Lb.textColor=[UIColor whiteColor];
    _src1Lb.textAlignment=NSTextAlignmentCenter;
    _src1Lb.text = @"待收益 (元)";
    [_bgImgView addSubview:_src1Lb];
    
    _money1Lb=[[UILabel alloc]init];
    _money1Lb.font = [UIFont s16];
    _money1Lb.textColor=[UIColor whiteColor];
    _money1Lb.textAlignment=NSTextAlignmentCenter;
    [_bgImgView addSubview:_money1Lb];
    
    _src2Lb=[[UILabel alloc]init];
    _src2Lb.font = [UIFont s12];
    _src2Lb.textColor=[UIColor whiteColor];
    _src2Lb.textAlignment=NSTextAlignmentCenter;
    _src2Lb.text = @"已收益 (元)";
    [_bgImgView addSubview:_src2Lb];
    
    _money2Lb=[[UILabel alloc]init];
    _money2Lb.font = [UIFont s16];
    _money2Lb.textColor=[UIColor whiteColor];
    _money2Lb.textAlignment=NSTextAlignmentCenter;
    [_bgImgView addSubview:_money2Lb];
    

    [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_offset(0);
    }];
    

    
   [_srcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.srcLb.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];

    [_src1Lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.money1Lb.mas_top).offset(-10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(self.bgImgView.mas_centerX);
    }];
    [_money1Lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.src1Lb);
        make.left.mas_equalTo(self.src1Lb);
        make.bottom.mas_equalTo(self.bgImgView.mas_bottom).offset(Iphonewidth==320 ? -20 : -30);

    }];
    
        [_money2Lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(self.bgImgView.mas_centerX).offset(10);
            make.centerY.mas_equalTo(self.money1Lb);
        }];

    [_src2Lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.src1Lb);
        make.left.mas_equalTo(self.bgImgView.mas_centerX).offset(10);
        make.right.mas_equalTo(-10);
    }];
}
@end
