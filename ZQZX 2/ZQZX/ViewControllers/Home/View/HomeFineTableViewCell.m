//
//  HomeFineTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/15.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HomeFineTableViewCell.h"

@implementation HomeFineTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.BKView=[[UIView alloc]init];
        self.BKView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.BKView];
        
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor m_red];
        [_BKView addSubview:_imgView];
        
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font = [UIFont s16];
        _titleLabel.textColor=[UIColor blackColor];
        _titleLabel.textAlignment=NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;
        [_BKView addSubview:_titleLabel];
        
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.font = [UIFont s12];
        _timeLabel.textColor=[UIColor blackColor];
        _timeLabel.textAlignment=NSTextAlignmentLeft;
        [_BKView addSubview:_timeLabel];
        
        _lineImg = [[UIImageView alloc]init];
        _lineImg.image = [UIImage imageNamed:@"shop_line"];
        [_BKView addSubview:_lineImg];
        
        [_BKView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
      
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(100, 100*0.56));
            make.bottom.mas_equalTo(-15);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgView);
            make.left.mas_equalTo(self.imgView.mas_right).offset(10);
            make.right.mas_equalTo(-10);
            make.height.mas_offset(50);
        }];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.imgView);
            make.left.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(-10);
        }];
        [_lineImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-1);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_offset(1);
        }];
        
        

    }
    
    return self;
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
