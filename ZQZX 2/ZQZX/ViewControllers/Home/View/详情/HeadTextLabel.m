//
//  HeadTextLabel.m
//  ZQZX
//
//  Created by 中企 on 2018/10/16.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HeadTextLabel.h"

@implementation HeadTextLabel

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
    
    _titleLabel=[[UILabel alloc]init];
    _titleLabel.font = [UIFont  s20];
    _titleLabel.textColor=[UIColor m_textDeepGrayColor];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    _srcLabel=[[UILabel alloc]init];
    _srcLabel.font = [UIFont s14];
    _srcLabel.textColor=[UIColor m_textGrayColor];
    _srcLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_srcLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor m_lineColor];
    [self addSubview:_lineView];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    [_srcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(1);
        make.right.mas_equalTo(-1);
        make.bottom.mas_equalTo(-15);
    }];
}
@end
