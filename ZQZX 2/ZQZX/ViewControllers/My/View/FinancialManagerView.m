//
//  FinancialManagerView.m
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "FinancialManagerView.h"

@implementation FinancialManagerView
- (instancetype)initWithType{
    self = [super init];
    
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI {
    _titleLb=[[UILabel alloc]init];
    _titleLb.font = [UIFont s16];
    _titleLb.textColor=[UIColor blackColor];
    _titleLb.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_titleLb];
    
    _nameLb=[[UILabel alloc]init];
    _nameLb.font = [UIFont s16];
    _nameLb.textColor=[UIColor m_textDeepGrayColor];
    _nameLb.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_nameLb];
    
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor m_lineColor];
    [self addSubview:_lineView];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(120);
        make.bottom.mas_offset(-10);
    }];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLb);
        make.left.mas_equalTo(self.titleLb.mas_right).offset(20);
        make.right.mas_equalTo(-10);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
        make.left.right.mas_equalTo(0);
        make.height.mas_offset(1);
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
