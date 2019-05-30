//
//  PlanTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "PlanTableViewCell.h"

@implementation PlanTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        
    }
    return self;
}
-(void)addUI{
    self.BKView=[[UIView alloc]init];
    self.BKView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.BKView];
    
    _titleLb=[[UILabel alloc]init];
    _titleLb.font = [UIFont s16];
    _titleLb.textColor=kTitleColor;
    _titleLb.textAlignment=NSTextAlignmentLeft;
    [self.BKView addSubview:_titleLb];
    
    _periodlab = [[UILabel alloc]init];
    _periodlab.font = [UIFont s16];
    _periodlab.textColor=kTitleColor;
    _periodlab.textAlignment=NSTextAlignmentLeft;
    [self.BKView addSubview:_periodlab];
    
    _typeView = [[OrderTextLabel alloc]initWithType];
    _typeView.titleLabel.text = @"产品类型";
    [self.BKView addSubview:_typeView];
    
    _moneyView = [[OrderTextLabel alloc]initWithType];
    _moneyView.titleLabel.text = @"本息金额";
    [self.BKView addSubview:_moneyView];
    
    _timeView = [[OrderTextLabel alloc]initWithType];
    [self.BKView addSubview:_timeView];
    
    [_BKView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [_periodlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.equalTo(self).offset(100);
    }];
    
    
    [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.typeView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.typeView);
        make.right.mas_equalTo(self.typeView);
    }];
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.typeView);
        make.right.mas_equalTo(self.typeView);
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
