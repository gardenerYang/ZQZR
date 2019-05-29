//
//  MyTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(cellType)type{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _type = type;
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
    _srcLb.font = [UIFont s16];
    _srcLb.textColor=[UIColor m_textDeepGrayColor];
    _srcLb.textAlignment=NSTextAlignmentRight;
    [self addSubview:_srcLb];
    UIView *lineView =[[UIView alloc]init];
    lineView.backgroundColor =[UIColor m_lineColor];
    [self addSubview:lineView];
    
    _arrowImg = [[UIImageView alloc]initWithImage:kImageNamed(@"arrow")];
    _arrowImg.hidden = YES;
    [self addSubview:_arrowImg];
    
    if (_type == cellTypeImg) {
        _headImg = [[UIImageView alloc]init];
        [self addSubview:_headImg];
        
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.bottom.mas_equalTo(-20);
        }];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.headImg);
            make.left.mas_equalTo(self.headImg.mas_right).offset(10);
            make.width.mas_equalTo(Iphonewidth == 320 ||Iphonewidth == 375 ? 150 : 200);
        }];
    }
    else{
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(Iphonewidth == 320 ||Iphonewidth == 375 ? 150 : 200);
            make.bottom.mas_equalTo(-20);
        }];
    }
    [_arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
    [_srcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLb);
        make.right.mas_equalTo(self.arrowImg.mas_left).offset(-5);
        make.left.mas_equalTo(self.titleLb.mas_right).offset(10);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-1);
    }];

    
}
-(void)updateLB{
    [_srcLb mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.arrowImg.hidden ==YES) {
            make.right.mas_equalTo(self).offset(-10);
        }else{
            make.right.mas_equalTo(self.arrowImg.mas_left).offset(-5);
        }
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
