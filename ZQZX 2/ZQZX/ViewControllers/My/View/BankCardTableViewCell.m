//
//  BankCardTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BankCardTableViewCell.h"

@implementation BankCardTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}
-(void)addUI{
    _bgImgView = [[UIImageView alloc]init];
    [self addSubview:_bgImgView];
    
    _photoImgView = [[UIImageView alloc]init];
    _photoImgView.backgroundColor = [UIColor whiteColor];
    _photoImgView.layer.masksToBounds = YES;
    _photoImgView.layer.cornerRadius = Iphonewidth==320 ? 20 : 25;
    [_bgImgView addSubview:_photoImgView];
    
    _titleLb=[[UILabel alloc]init];
    _titleLb.font = [UIFont s16];
    _titleLb.textColor=[UIColor whiteColor];
    _titleLb.textAlignment=NSTextAlignmentLeft;
    [_bgImgView addSubview:_titleLb];
    
    _srcLb=[[UILabel alloc]init];
    _srcLb.font = [UIFont s14];
    _srcLb.textColor=[UIColor whiteColor];
    _srcLb.textAlignment=NSTextAlignmentLeft;
    [_bgImgView addSubview:_srcLb];

    
    _numLb=[[UILabel alloc]init];
    _numLb.font = [UIFont boldSystemFontOfSize:22];
    _numLb.textColor=[UIColor whiteColor];
    _numLb.textAlignment=NSTextAlignmentLeft;
    [_bgImgView addSubview:_numLb];
    
    [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(self.bgImgView.mas_width).multipliedBy(0.33);
        make.bottom.mas_equalTo(0);
    }];
    [_photoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Iphonewidth==320 ? 10:30);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(Iphonewidth==320 ? 40:50, Iphonewidth==320 ? 40:50));
    }];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoImgView);
        make.left.mas_equalTo(self.photoImgView.mas_right).offset(10);
        make.right.mas_equalTo(-10);
    }];
    [_srcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(5);
        make.left.mas_equalTo(self.titleLb);
        make.right.mas_equalTo(self.titleLb);
    }];
    [_numLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgImgView.mas_bottom).offset(Iphonewidth==320 ? -20 : -30);
        make.left.mas_equalTo(self.titleLb);
        make.right.mas_equalTo(self.titleLb);
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
