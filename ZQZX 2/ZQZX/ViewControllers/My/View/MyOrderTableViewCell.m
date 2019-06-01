//
//  MyOrderTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        self.backgroundColor = [UIColor m_gray];

    }
    return self;
}
-(void)addUI{

    self.BKView=[[UIView alloc]init];
    self.BKView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.BKView];
    
    _orderNumLb=[[UILabel alloc]init];
    _orderNumLb.font = [UIFont s14];
    _orderNumLb.textColor=[UIColor m_textDeepGrayColor];
    _orderNumLb.textAlignment=NSTextAlignmentLeft;
    [self.BKView addSubview:_orderNumLb];
    
    
    _timeLb=[[UILabel alloc]init];
    _timeLb.font = [UIFont s14];
    _timeLb.textColor=kLightGray;
    _timeLb.textAlignment=NSTextAlignmentRight;
    [self.BKView addSubview:_timeLb];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor =[UIColor m_lineColor];
    [self.BKView addSubview:lineView];
    
    
    _titleLb=[[UILabel alloc]init];
    _titleLb.font = [UIFont s16];
    _titleLb.textColor=kTitleColor;
    _titleLb.textAlignment=NSTextAlignmentLeft;
    [self.BKView addSubview:_titleLb];
    
    _tagLb=[[UILabel alloc]init];
    _tagLb.font = [UIFont s12];
    _tagLb.textColor=kMainColor;
    _tagLb.textAlignment=NSTextAlignmentCenter;
    _tagLb.layer.borderColor = kMainColor.CGColor;
    _tagLb.layer.borderWidth = 1;
    _tagLb.layer.masksToBounds = YES;
    _tagLb.layer.cornerRadius = 5;
    [self.BKView addSubview:_tagLb];
    
    _jianImg = [[UIImageView alloc]init];
    _jianImg.image = [UIImage imageNamed:@"arrow"];
    [self.BKView addSubview:_jianImg];
    
    _src1Lb=[[UILabel alloc]init];
    _src1Lb.font = [UIFont s12];
    _src1Lb.textColor=[UIColor m_textDeepGrayColor];
    _src1Lb.textAlignment=NSTextAlignmentCenter;
    _src1Lb.text = @"预约金额";
    [self.BKView addSubview:_src1Lb];
    
    _moneyLb=[[UILabel alloc]init];
    _moneyLb.font = [UIFont s16];
    _moneyLb.textColor=kTitleColor;
    _moneyLb.textAlignment=NSTextAlignmentCenter;
    
    [self.BKView addSubview:_moneyLb];
    
    _src2Lb=[[UILabel alloc]init];
    _src2Lb.font = [UIFont s12];
    _src2Lb.textColor=[UIColor m_textDeepGrayColor];
    _src2Lb.textAlignment=NSTextAlignmentCenter;
    _src2Lb.text = @"预期年化收益率";
    [self.BKView addSubview:_src2Lb];
    
    _numLb=[[UILabel alloc]init];
    _numLb.font = [UIFont s16];
    _numLb.textColor=kTitleColor;
    _numLb.textAlignment=NSTextAlignmentCenter;
    [self.BKView addSubview:_numLb];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor =[UIColor m_lineColor];
    [self.BKView addSubview:lineView1];
    
    [_BKView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    
   [_orderNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(self.timeLb.mas_left).offset(-5);
    }];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.orderNumLb);
        make.width.mas_equalTo(80);
        make.right.mas_equalTo(-10);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumLb.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(1);
    }];
    
     [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-120);
    }];
   
    [_jianImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLb);
        make.size.mas_equalTo(CGSizeMake(10, 17));
        make.right.mas_equalTo(-10);
    }];
    [_tagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLb);
        make.width.mas_equalTo(80);
        make.right.mas_equalTo(-35);
    }];
    
    [_src1Lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(self.BKView.mas_centerX);
    }];
    [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.src1Lb.mas_bottom).offset(10);
        make.left.mas_equalTo(self.src1Lb);
        make.right.mas_equalTo(self.src1Lb);
        make.bottom.mas_offset(-10);
    }];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(20);
        make.width.mas_equalTo(1);
        make.left.mas_equalTo(self.moneyLb.mas_right);
        make.bottom.mas_equalTo(-20);

    }];
    [_src2Lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.src1Lb);
        make.left.mas_equalTo(self.BKView.mas_centerX);
        make.right.mas_equalTo(-10);
    }];
    [_numLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.src2Lb.mas_bottom).offset(10);
        make.left.mas_equalTo(self.src2Lb);
        make.right.mas_equalTo(self.src2Lb);
        make.bottom.mas_offset(-10);
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
