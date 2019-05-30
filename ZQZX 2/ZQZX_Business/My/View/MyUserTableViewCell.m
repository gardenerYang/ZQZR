//
//  MyUserTableViewCell.m
//  ZQZX_Business
//
//  Created by 中企 on 2018/10/23.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyUserTableViewCell.h"

@implementation MyUserTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    _nameLb=[[UILabel alloc]init];
    _nameLb.font = [UIFont s16];
    _nameLb.textColor=kTitleColor;
    _nameLb.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_nameLb];
    
    _phoneLb=[[UILabel alloc]init];
    _phoneLb.font = [UIFont s14];
    _phoneLb.textColor=kTitleColor;
    _phoneLb.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_phoneLb];
    
    _cityLb=[[UILabel alloc]init];
    _cityLb.font = [UIFont s14];
    _cityLb.textColor=kTitleColor;
    _cityLb.textAlignment=NSTextAlignmentRight;
    [self addSubview:_cityLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(Iphonewidth/3);
        make.bottom.mas_equalTo(-20);
    }];
    [_phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLb);
        make.left.mas_equalTo(self.nameLb.mas_right);
        make.width.mas_equalTo(Iphonewidth/3);
    }];
    [_cityLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLb);
        make.left.mas_equalTo(self.phoneLb.mas_right);
        make.right.mas_equalTo(-10);
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
