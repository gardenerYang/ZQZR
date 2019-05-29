//
//  OrderTextLabel.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "OrderTextLabel.h"

@implementation OrderTextLabel
- (instancetype)initWithType{
    self = [super init];
    
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI {
    
    _titleLabel=[[UILabel alloc]init];
    _titleLabel.font = [UIFont s12];
    _titleLabel.textColor=[UIColor m_textGrayColor];
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _srcLabel=[[UILabel alloc]init];
    _srcLabel.font = [UIFont s12];
    _srcLabel.textColor=[UIColor m_textDeepGrayColor];
    _srcLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:_srcLabel];
 
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(-10);
    }];
    [_srcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.right.mas_equalTo(-10);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
