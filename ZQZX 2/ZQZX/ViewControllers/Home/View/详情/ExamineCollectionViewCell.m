//
//  ExamineCollectionViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ExamineCollectionViewCell.h"

@implementation ExamineCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
   
    _titleLB=[[UILabel alloc]init];
    _titleLB.font = [UIFont s16];
    _titleLB.textColor=[UIColor m_textDeepGrayColor];
    _titleLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_titleLB];
    
    
    _stateLB=[[UILabel alloc]init];
    _stateLB.font = [UIFont s16];
    _stateLB.textColor=[UIColor withHexStr:@"#24942b"];
    _stateLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_stateLB];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor =[UIColor m_lineColor];
    [self addSubview:_bottomLine];
    
    _rightLine = [[UIView alloc]init];
    _rightLine.backgroundColor =[UIColor m_lineColor];
    [self addSubview:_rightLine];
    
   
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [_stateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLB.mas_bottom).offset(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-20);
    }];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_bottom).offset(-1);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-1);
        make.bottom.mas_equalTo(-1);
        make.width.mas_equalTo(1);
    }];
    
    
}
@end
