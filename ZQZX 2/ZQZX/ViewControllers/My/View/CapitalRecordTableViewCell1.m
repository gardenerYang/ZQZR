//
//  CapitalRecordTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "CapitalRecordTableViewCell1.h"

@implementation CapitalRecordTableViewCell1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}
-(void)addUI{
    _titleLb=[[UILabel alloc]init];
    _titleLb.font = [UIFont s16];
    _titleLb.textColor=kTitleColor;
    _titleLb.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_titleLb];
    
    _timeLb=[[UILabel alloc]init];
    _timeLb.font = [UIFont s14];
    _timeLb.textColor=kLightGray;
    _timeLb.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_timeLb];
    
    
    _priceLb=[[UILabel alloc]init];
    _priceLb.font = [UIFont s14];
    _priceLb.textColor=kMainColor;
    _priceLb.textAlignment=NSTextAlignmentRight;
    [self addSubview:_priceLb];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(150);
        make.bottom.mas_offset(-10);
    }];
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeLb);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(self.timeLb.mas_right).offset(10);
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
