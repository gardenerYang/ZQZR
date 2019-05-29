//
//  MyBusinessHeadView.m
//  ZQZX
//
//  Created by 中企 on 2018/10/22.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyBusinessHeadView.h"

@implementation MyBusinessHeadView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI {
    _headView = [[UIView alloc]init];
    [self addSubview:_headView];
    
    _headImgView = [[UIImageView alloc]init];
    _headImgView.image = [UIImage imageNamed:@"headbg"];
    [_headView addSubview:_headImgView];
    
    _photoImgView = [[UIImageView alloc]init];
    _photoImgView.backgroundColor = [UIColor whiteColor];
    _photoImgView.layer.masksToBounds = YES;
    _photoImgView.layer.cornerRadius = 30;
    [_headImgView addSubview:_photoImgView];
    
    _titleLabel=[[UILabel alloc]init];
    _titleLabel.font = [UIFont s20];
    _titleLabel.textColor=[UIColor whiteColor];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    [_headImgView addSubview:_titleLabel];
    
    
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(self.headImgView.mas_width).multipliedBy(0.52);
        make.bottom.mas_equalTo(-10);
    }];
    
    [_photoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImgView.mas_centerY).offset(-30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.mas_equalTo(self.headImgView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoImgView.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
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
