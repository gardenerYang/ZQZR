//
//  MyNavView.m
//  ZQZX
//
//  Created by 中企 on 2018/10/18.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyNavView.h"

@implementation MyNavView

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
    
    _navView = [[UIView alloc]init];
    [self addSubview:_navView];
    
    _photoImg = [[UIImageView alloc]init];
//    _photoImg.image = [UIImage imageNamed:@"my_photo"];
    _photoImg.layer.cornerRadius = 15;
    _photoImg.layer.masksToBounds =YES;
   
     [_navView addSubview:_photoImg];
    
    _nameLb=[[UILabel alloc]init];
    _nameLb.font = [UIFont s20];
    _nameLb.textColor=[UIColor m_textDeepGrayColor];
    _nameLb.textAlignment=NSTextAlignmentLeft;
    [_navView addSubview:_nameLb];
    
    _setupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_setupBtn setImage:[UIImage imageNamed:@"my_setup"] forState:UIControlStateNormal];
    [_setupBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
    __weak typeof(self) wf = self;

    _setupBtn.titleLabel.font = [UIFont s14];
    [_setupBtn addAction:^(UIButton *sender) {
        if (wf.tapBtnblock) {
            wf.tapBtnblock();
        }
    }];
    [_navView addSubview:_setupBtn];
    [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_offset(0);
    }];
    
    [_photoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(StatusBarHight/2);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
//        make.bottom.mas_offset(-5);
    }];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.photoImg);
        make.left.mas_equalTo(self.photoImg.mas_right).offset(10);
        make.right.mas_equalTo(-100);
    }];
    [_setupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.photoImg);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
}
@end
