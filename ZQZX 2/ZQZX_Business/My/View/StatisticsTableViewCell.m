//
//  StatisticsTableViewCell.m
//  ZQZX_Business
//
//  Created by 中企 on 2018/10/23.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "StatisticsTableViewCell.h"

@implementation StatisticsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    
    _imgView = [[UIImageView alloc]init];
    [self addSubview:_imgView];
  
    _srcNumLb=[[UILabel alloc]init];
    _srcNumLb.font = [UIFont s16];
    _srcNumLb.textColor=[UIColor m_textDeepGrayColor];
    _srcNumLb.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_srcNumLb];
    
    _numLb=[[UILabel alloc]init];
    _numLb.font = [UIFont s16];
    _numLb.textColor=[UIColor blackColor];
    _numLb.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_numLb];
    
    _srcMoneyLB=[[UILabel alloc]init];
    _srcMoneyLB.font = [UIFont s16];
    _srcMoneyLB.textColor=[UIColor m_textDeepGrayColor];
    _srcMoneyLB.textAlignment=NSTextAlignmentRight;
    [self addSubview:_srcMoneyLB];
    
    _moneyLB=[[UILabel alloc]init];
    _moneyLB.font = [UIFont s16];
    _moneyLB.textColor=[UIColor blackColor];
    _moneyLB.textAlignment=NSTextAlignmentRight;
    [self addSubview:_moneyLB];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.mas_equalTo(-20);
    }];
    
    [_srcNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView);
        make.left.mas_equalTo(self.imgView.mas_right).offset(5);
        make.width.mas_equalTo(Iphonewidth/2 - 60);
    }];
    [_numLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.srcNumLb.mas_bottom).offset(10);
        make.left.mas_equalTo(self.srcNumLb);
        make.right.mas_equalTo(self.srcNumLb);
    }];
    
    
    [_srcMoneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.srcNumLb);
        make.left.mas_equalTo(self.srcNumLb.mas_right).offset(10);
        make.right.mas_equalTo(-20);
    }];
    [_moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numLb);
        make.left.mas_equalTo(self.srcMoneyLB);
        make.right.mas_equalTo(self.srcMoneyLB);
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
