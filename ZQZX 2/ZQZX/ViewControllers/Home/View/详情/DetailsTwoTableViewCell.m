//
//  DetailsTwoTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/29.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "DetailsTwoTableViewCell.h"

@implementation DetailsTwoTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}
-(void)addUI{
    _imgView = [[UIImageView alloc]init];
    _imgView.image = [UIImage imageNamed:@"ticketHeader"];
    [self addSubview:_imgView];
    _xialaView = [[UIImageView alloc]init];
    _xialaView.image = [UIImage imageNamed:@"botoom_jiantou"];
    [self addSubview:_xialaView];
    
    _srcLb=[[UILabel alloc]init];
    _srcLb.font = [UIFont s14];
    _srcLb.textColor=[UIColor m_textLighGrayColor];
    _srcLb.textAlignment=NSTextAlignmentCenter;
    _srcLb.text=@"上拉查看更多详情";
    [self addSubview:_srcLb];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(self.imgView.mas_width).multipliedBy(0.5);
    }];
    [_xialaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.imgView);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [_srcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.xialaView.mas_bottom).offset(10);
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
