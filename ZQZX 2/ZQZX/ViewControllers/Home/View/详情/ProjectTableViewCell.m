//
//  ProjectTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ProjectTableViewCell.h"

@implementation ProjectTableViewCell
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
    

    
    _srcLb=[[UILabel alloc]init];
    _srcLb.font = [UIFont s14];
    _srcLb.textColor = [UIColor m_textDeepGrayColor];
    _srcLb.numberOfLines = 0;
    _srcLb.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_srcLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [_srcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_offset(-10);
    }];

}
- (void)setIsShowImage:(BOOL)isShowImage{
    if (isShowImage) {
        _imageV = [[UIImageView alloc]initWithImage:kImageNamed(@"lilv")];
        [self addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.right.equalTo(self).offset(-12);
            make.bottom.equalTo(self).offset(-5);
            make.top.equalTo(self.titleLb.mas_bottom).offset(5);
            make.height.mas_equalTo((kWidth-24)*231/690);
        }];
    }else{
        [_imageV removeFromSuperview];
    }
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
