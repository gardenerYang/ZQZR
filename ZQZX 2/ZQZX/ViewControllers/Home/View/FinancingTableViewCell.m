//
//  FinancingTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/15.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "FinancingTableViewCell.h"

@implementation FinancingTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}
-(void)addUI
{
    self.BKView=[[UIView alloc]init];
    self.BKView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.BKView];
    
    _titleLabel=[[UILabel alloc]init];
    _titleLabel.font = [UIFont s16];
    _titleLabel.textColor=kTitleColor;
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    [_BKView addSubview:_titleLabel];
    
    _stateLb=[[UILabel alloc]init];
    _stateLb.font = [UIFont s12];
    _stateLb.textColor=[UIColor whiteColor];
    _stateLb.textAlignment=NSTextAlignmentCenter;
    _stateLb.backgroundColor = kMainColor;
    [_BKView addSubview:_stateLb];
    
    _numLb=[[UILabel alloc]init];
    _numLb.font = [UIFont s16];
    _numLb.textColor=[UIColor m_textDeepGrayColor];
    _numLb.textAlignment=NSTextAlignmentCenter;
    [_BKView addSubview:_numLb];
    
    _srcnumLb=[[UILabel alloc]init];
    _srcnumLb.font = [UIFont s12];
    _srcnumLb.textColor=kLightGray;
    _srcnumLb.textAlignment=NSTextAlignmentCenter;
    [_BKView addSubview:_srcnumLb];
    
    _dayLb=[[UILabel alloc]init];
    _dayLb.font = [UIFont s16];
    _dayLb.textColor=[UIColor m_textDeepGrayColor];
    _dayLb.textAlignment=NSTextAlignmentCenter;
    [_BKView addSubview:_dayLb];
    
    _srcdayLb=[[UILabel alloc]init];
    _srcdayLb.font = [UIFont s12];
    _srcdayLb.textColor=kLightGray;
    _srcdayLb.textAlignment=NSTextAlignmentCenter;
    _stateLb.layer.masksToBounds = YES;
    _stateLb.layer.cornerRadius = 2;
    [_BKView addSubview:_srcdayLb];
    
    _interestsLb=[[UIImageView alloc]init];
    _interestsLb.layer.masksToBounds = YES;
    _interestsLb.hidden = YES;
    [_interestsLb setImage:[UIImage imageNamed:@"xi"]];
    [_BKView addSubview:_interestsLb];
    
    _moneyLb=[[UILabel alloc]init];
    _moneyLb.font = [UIFont s16];
    _moneyLb.textColor=[UIColor m_textDeepGrayColor];
    _moneyLb.textAlignment=NSTextAlignmentCenter;
    [_BKView addSubview:_moneyLb];
    
    _srcmoneyLb=[[UILabel alloc]init];
    _srcmoneyLb.font = [UIFont s12];
    _srcmoneyLb.textColor=kLightGray;
    _srcmoneyLb.textAlignment=NSTextAlignmentCenter;
    [_BKView addSubview:_srcmoneyLb];
    
    _progressView=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.trackTintColor=[UIColor withHexStr:@"f7f3f3"];
    _progressView.progressTintColor=[UIColor withHexStr:@"e1292a"];
    for (UIImageView * imageview in self.progressView.subviews) {
        imageview.layer.cornerRadius = 1.5;
        imageview.clipsToBounds = YES;
    }
    _progressView.progress = 0.5;
    [self addSubview:_progressView];
    _progressLabel = [[UILabel alloc]init];
    [self.BKView addSubview:_progressLabel];
    _progressLabel.text = @"40%";
    _progressLabel.textColor = kTitleColor;
    _progressLabel.font = kFont(9);
    
    self.timeLb = [[HomeTimeLabel alloc]init];
    
    [self.BKView addSubview:self.timeLb];
    self.timeLb.font = kFont(10);
    self.timeLb.textColor = [UIColor withHexStr:@"737373"];
    
    UIImageView *lineImg = [[UIImageView alloc]init];
    lineImg.backgroundColor = [UIColor withHexStr:@"eeeeee"];
    [_BKView addSubview:lineImg];
    
    [_BKView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        //        make.right.lessThanOrEqualTo(self.stateLb.mas_left).offset(-5);
        make.right.lessThanOrEqualTo(@(-70));
    }];
    
    [_interestsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numLb.mas_centerY).offset(-5);
        make.left.mas_equalTo(self.numLb.mas_right).offset(5);
        
    }];
    [_stateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self).offset(-10);
        make.width.mas_equalTo(50);
        //        make.right.mas_equalTo(-10);
    }];
    [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [_numLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(10);
        
    }];
    
    
    [_srcnumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numLb.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(kWidth/3);
        make.bottom.mas_offset(-70);
    }];
    
    
    
    
    [_dayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numLb);
        make.left.mas_equalTo(self.srcnumLb.mas_right);
        make.width.mas_equalTo(Iphonewidth/3);
    }];
    
    [_srcdayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.srcnumLb);
        make.left.mas_equalTo(self.dayLb);
        make.width.mas_equalTo(self.dayLb);
    }];
    
    [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.dayLb);
        make.left.mas_equalTo(self.dayLb.mas_right);
        make.width.mas_equalTo(Iphonewidth/3);
    }];
    
    [_srcmoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.srcdayLb);
        make.left.mas_equalTo(self.moneyLb);
        make.width.mas_equalTo(Iphonewidth/3);
    }];
    [_numLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.srcnumLb);
    }];
    _srcnumLb.text = @"预期年化收益率";
    _srcdayLb.text = @"期限";
    _srcmoneyLb.text = @"起投金额";

    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.srcnumLb.mas_bottom).offset(15);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(3);
    }];
    UILabel * timeTitle = [[UILabel alloc]init];
    [self.BKView addSubview:timeTitle];
    timeTitle.text = @"剩余募集时间: ";
    timeTitle.font = kFont(10);
    timeTitle.textColor = [UIColor withHexStr:@"737373"];
    [timeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.progressView.mas_bottom).offset(15);
    }];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeTitle.mas_right);
        make.top.equalTo(self.progressView.mas_bottom).offset(15);
    }];
    [_progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self.timeLb);
    }];
    [lineImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.equalTo(@10);
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


