//
//  PhotoTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "PhotoTableViewCell.h"

@implementation PhotoTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        
    }
    return self;
}
-(void)addUI{
    _titleLb=[[UILabel alloc]init];
    _titleLb.font = [UIFont s16];
    _titleLb.textColor=[UIColor blackColor];
    _titleLb.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_titleLb];
    
    _photoImg = [[UIImageView alloc]init];
    _photoImg.backgroundColor =[UIColor m_red];
    _photoImg.layer.masksToBounds = YES;
    _photoImg.layer.cornerRadius = 20;
    [self addSubview:_photoImg];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-100);
        make.bottom.mas_equalTo(-20);
    }];
    [_photoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLb);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
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
