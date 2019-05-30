//
//  InvestmentManagementCell.m
//  ZQZX_Business
//
//  Created by 中企 on 2018/10/23.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "InvestmentManagementCell.h"

@implementation InvestmentManagementCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor m_bgColor];
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    self.BKView=[[UIView alloc]init];
    self.BKView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.BKView];
    
    _imgView = [[UIImageView alloc]init];
    [_BKView addSubview:_imgView];
    
    _nameLb=[[UILabel alloc]init];
    _nameLb.font = [UIFont s16];
    _nameLb.textColor=kTitleColor;
    _nameLb.textAlignment=NSTextAlignmentLeft;
    [_BKView addSubview:_nameLb];
    
    _money1Lb=[[UILabel alloc]init];
    _money1Lb.font = [UIFont s14];
    _money1Lb.textColor=kTitleColor;
    _money1Lb.textAlignment=NSTextAlignmentRight;
    [_BKView addSubview:_money1Lb];
    
//    _lineView = [[UIView alloc]init];
//    _lineView.backgroundColor = [UIColor m_lineColor];
//    [_BKView addSubview:_lineView];
    
    
    _money2Lb=[[UILabel alloc]init];
    _money2Lb.font = [UIFont s14];
    _money2Lb.textColor=kTitleColor;
    _money2Lb.textAlignment=NSTextAlignmentRight;
    [_BKView addSubview:_money2Lb];
    
    _line1View = [[UIView alloc]init];
    _line1View.backgroundColor = [UIColor m_lineColor];
    [_BKView addSubview:_line1View];
    
    _money3Lb=[[UILabel alloc]init];
    _money3Lb.font = [UIFont s14];
    _money3Lb.textColor=[UIColor m_red];
    _money3Lb.textAlignment=NSTextAlignmentRight;
    [_BKView addSubview:_money3Lb];
    
    [_BKView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imgView);
        make.left.mas_equalTo(self.imgView.mas_right).offset(10);
        make.width.mas_equalTo(100);
    }];
    [_money1Lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(self.nameLb.mas_right).offset(10);
    }];
    
//    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.money1Lb);
//        make.left.mas_equalTo(self.money1Lb.mas_right);
//        make.width.mas_equalTo(1);
//        make.height.mas_offset(20);
//    }];
    [_money2Lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.money1Lb.mas_bottom).offset(10);
        make.left.mas_equalTo(self.imgView.mas_right).offset(10);
        make.right.mas_equalTo(-10);
    }];
    
    [_line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(1);
    }];
    [_money3Lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line1View.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
