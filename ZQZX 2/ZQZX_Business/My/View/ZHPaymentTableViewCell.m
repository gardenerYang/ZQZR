//
//  ZHPaymentTableViewCell.m
//  Ninesecretary
//
//  Created by chenglian on 2017/11/3.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "ZHPaymentTableViewCell.h"

@implementation ZHPaymentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.titleLabel];

        [self.contentView addSubview:self.selectBtn];
        [self.contentView addSubview:self.bigSelectBtn];
    }
    return self;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, Iphonewidth - 100, 30)];
        self.titleLabel.font=[UIFont s14] ;
        self.titleLabel.textColor=[UIColor m_textDeepGrayColor];
    }
    return _titleLabel;
}
- (UIButton *)selectBtn{
    if (!_selectBtn) {
        //选中按钮
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectBtn.frame = CGRectMake(Iphonewidth - 45, 15, 20, 20);
        self.selectBtn.selected = self.isSelected;
        [self.selectBtn setImage:[UIImage imageNamed:@"unSelect_btn"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateSelected];
    }
    return _selectBtn;
}
- (UIButton *)bigSelectBtn{
    if (!_bigSelectBtn) {
        //选中按钮
        _bigSelectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _bigSelectBtn.frame = CGRectMake(0, 0, Iphonewidth , 60);
        _bigSelectBtn.backgroundColor = [UIColor clearColor];
        [_bigSelectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigSelectBtn;
}
//选中按钮点击事件
-(void)selectBtnClick
{
    self.selectBtn.selected = !self.selectBtn.selected;
    if (self.payBlock) {
        self.payBlock(self.selectBtn.selected);
    }
}
-(void)reloadDataWith
{
    self.selectBtn.selected = self.isSelected;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
