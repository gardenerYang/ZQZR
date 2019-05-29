//
//  RecordListTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "RecordListTableViewCell.h"

@implementation RecordListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}
-(void)addUI{
    _nameLb=[[UILabel alloc]init];
    _nameLb.font = [UIFont s14];
    _nameLb.textColor=[UIColor m_textDeepGrayColor];
    _nameLb.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_nameLb];
    
    _moneyLb=[[UILabel alloc]init];
    _moneyLb.font = [UIFont s14];
    _moneyLb.textColor = [UIColor m_textDeepGrayColor];
    _moneyLb.numberOfLines = 0;
    _moneyLb.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_moneyLb];
    
    _timeLb=[[UILabel alloc]init];
    _timeLb.font = [UIFont s14];
    _timeLb.textColor = [UIColor m_textDeepGrayColor];
    _timeLb.numberOfLines = 0;
    _timeLb.textAlignment=NSTextAlignmentRight;
    [self addSubview:_timeLb];
    
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(100);
        make.bottom.mas_equalTo(-10);
    }];
    [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(100);
        make.centerY.mas_equalTo(self.nameLb);
    }];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(self.nameLb.mas_right).offset(10);
        make.centerY.mas_equalTo(self.nameLb);
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
