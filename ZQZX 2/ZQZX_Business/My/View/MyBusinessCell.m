//
//  MyBusinessCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/22.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyBusinessCell.h"

@implementation MyBusinessCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    _headimgView = [[UIImageView alloc]init];
    [self addSubview:_headimgView];
    
    _titleLB=[[UILabel alloc]init];
    _titleLB.font = [UIFont s16];
    _titleLB.textColor=[UIColor blackColor];
    _titleLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_titleLB];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor =[UIColor m_lineColor];
    [self addSubview:_bottomLine];
    
    _rightLine = [[UIView alloc]init];
    _rightLine.backgroundColor =[UIColor m_lineColor];
    [self addSubview:_rightLine];
    
    [_headimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headimgView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
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
