//
//  DetailsTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/16.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "DetailsTableViewCell.h"

@implementation DetailsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}
-(void)addUI{
    self.BKView=[[UIView alloc]init];
    self.BKView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.BKView];
    
    _icon1 = [[UIImageView alloc]init];
    _icon1.image = [UIImage imageNamed:@"ben"];
    [_BKView addSubview:_icon1];
    
    _icon2 = [[UIImageView alloc]init];
    _icon2.image = [UIImage imageNamed:@"zeng"];
    [_BKView addSubview:_icon2];
    
    _titleLb1=[[UILabel alloc]init];
    _titleLb1.font =  Iphonewidth == 320 ?  [UIFont s12] : [UIFont s14];
    _titleLb1.textColor=[UIColor m_textDeepGrayColor];
    _titleLb1.textAlignment=NSTextAlignmentLeft;
    [_BKView addSubview:_titleLb1];
    
    _titleLb2=[[UILabel alloc]init];
    _titleLb2.font = Iphonewidth == 320 ?  [UIFont s12] : [UIFont s14];
    _titleLb2.textColor=[UIColor m_textDeepGrayColor];
    _titleLb2.textAlignment=NSTextAlignmentLeft;
    [_BKView addSubview:_titleLb2];
    
    [_BKView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    
    
    [_icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.bottom.mas_equalTo(-20);
    }];
    [_titleLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.icon1);
        make.left.mas_equalTo(self.icon1.mas_right).offset(10);
        make.right.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    [_icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.icon1);
        make.left.mas_equalTo(self.titleLb1.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [_titleLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.icon2);
        make.left.mas_equalTo(self.icon2.mas_right).offset(10);
        make.right.mas_equalTo(-5);
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
