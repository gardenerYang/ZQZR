//
//  HomeTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/15.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.BKView=[[UIView alloc]init];
        self.BKView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.BKView];

        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font = [UIFont s16];
        _titleLabel.textColor=[UIColor blackColor];
        _titleLabel.textAlignment=NSTextAlignmentLeft;
        
        [_BKView addSubview:_titleLabel];
        
        
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"更多>>" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor m_textGrayColor] forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont s14];
        __weak typeof(self) wf = self;
        [_moreBtn addAction:^(UIButton *sender) {
            if (wf.morebtnClickBlock) {
                wf.morebtnClickBlock();
            }
        }];
        [_BKView addSubview:_moreBtn];
        
        _linevView = [[UIView alloc]init];
        _linevView.backgroundColor = [UIColor m_lineColor];
        [_BKView addSubview:_linevView];
        
        _numTitleLb=[[UILabel alloc]init];
        _numTitleLb.font = [UIFont s16];
        _numTitleLb.textColor=[UIColor blackColor];
        _numTitleLb.textAlignment=NSTextAlignmentCenter;
        [_BKView addSubview:_numTitleLb];
        
        _srcTitleLb=[[UILabel alloc]init];
        _srcTitleLb.font = [UIFont s12];
        _srcTitleLb.textColor=[UIColor m_textGrayColor];
        _srcTitleLb.textAlignment=NSTextAlignmentCenter;
        [_BKView addSubview:_srcTitleLb];
        
        _titleLb=[[UILabel alloc]init];
        _titleLb.font = [UIFont s14];
        _titleLb.textColor=[UIColor blackColor];
        _titleLb.textAlignment=NSTextAlignmentLeft;
        [_BKView addSubview:_titleLb];
        
        _stateLb=[[UILabel alloc]init];
        _stateLb.font = [UIFont s12];
        _stateLb.textColor=[UIColor whiteColor];
        _stateLb.textAlignment=NSTextAlignmentCenter;
        _stateLb.backgroundColor = [UIColor m_Lightred];
        _stateLb.layer.cornerRadius = 2;
        _stateLb.layer.masksToBounds = YES;
        [_BKView addSubview:_stateLb];
        
        _interestsLb=[[UIImageView alloc]init];
        [_interestsLb setImage:[UIImage imageNamed:@"xi"]];
        _interestsLb.layer.cornerRadius = 2;
        _interestsLb.layer.masksToBounds = YES;
        _interestsLb.hidden = YES;
        [_BKView addSubview:_interestsLb];
        
        _dayLb=[[UILabel alloc]init];
        _dayLb.font = [UIFont s12];
        _dayLb.textColor=[UIColor m_textDeepGrayColor];
        _dayLb.textAlignment=NSTextAlignmentCenter;
        [_BKView addSubview:_dayLb];
        
        _moneyLb=[[UILabel alloc]init];
        _moneyLb.font = [UIFont s10];
        _moneyLb.textColor=[UIColor m_textDeepGrayColor];
        _moneyLb.textAlignment=NSTextAlignmentCenter;
        [_BKView addSubview:_moneyLb];
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
        
        UIView *linevView1 = [[UIView alloc]init];
        linevView1.backgroundColor = [UIColor m_lineColor];
        [_BKView addSubview:linevView1];
        
        UIView *linevView2 = [[UIView alloc]init];
        linevView2.backgroundColor = [UIColor m_lineColor];
        [_BKView addSubview:linevView2];
        UILabel * timeTitle = [[UILabel alloc]init];
        self.timeTitle = timeTitle;
        [self.BKView addSubview:timeTitle];
        timeTitle.text = @"剩余募集时间: ";
        timeTitle.font = kFont(10);
        timeTitle.textColor = [UIColor withHexStr:@"737373"];
        
        self.timeLb = [[HomeTimeLabel alloc]init];
        [self.BKView addSubview:self.timeLb];
        self.timeLb.font = kFont(10);
        self.timeLb.textColor = [UIColor withHexStr:@"737373"];
        
        CGFloat labelW = (kWidth-20)/3;
        [_BKView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-100);
            make.height.mas_equalTo(30);

        }];
        
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLabel);
            make.width.mas_equalTo(60);
            make.right.mas_equalTo(-10);
        }];
        
        [_linevView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        UIView * bgView = [[UIView alloc]init];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        [_numTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.linevView.mas_bottom).offset(20);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(80);
        }];
        [_srcTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.linevView.mas_bottom).offset(46);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(labelW);
            make.bottom.mas_offset(-50);
        }];
        
        [linevView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.linevView.mas_bottom).offset(15);
            make.left.mas_equalTo(self.srcTitleLb.mas_right).offset(10);
            make.width.mas_equalTo(1);
            make.bottom.mas_equalTo(-80);
        }];
        
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.numTitleLb.mas_centerY);
            make.left.mas_equalTo(linevView1.mas_right).offset(10);
            make.right.mas_equalTo(-100);
        }];

        [_stateLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLb.mas_centerY);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(50);
        }];
        [_interestsLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLb.mas_centerY).offset(-5);
            make.left.mas_equalTo(self.numTitleLb.mas_right).offset(4);
        }];
        [_dayLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.srcTitleLb.mas_centerY);
            make.width.mas_equalTo(labelW);
            make.left.mas_equalTo(self.titleLb);
        }];
        [linevView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dayLb.mas_right);
            make.width.mas_equalTo(1);
            make.top.mas_equalTo(self.titleLb.mas_bottom).offset(10);
            make.bottom.mas_equalTo(linevView1);
        }];
  
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.mas_equalTo(self.srcTitleLb.mas_bottom).offset(0);
            make.right.equalTo(self).offset(-10);
            make.height.mas_equalTo(3);
        }];
        [timeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self.progressView.mas_bottom).offset(15);
        }];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(timeTitle.mas_right).offset(10);
            make.top.equalTo(self.progressView.mas_bottom).offset(15);
        }];
        [_progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(self.timeLb);
        }];
        _progressLabel.text = @"40%";
        [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(linevView2.mas_right);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.dayLb);
        }];
        [_numTitleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.linevView.mas_bottom).offset(20);
            make.centerX.mas_equalTo(self.srcTitleLb);
        }];
        _titleLabel.text = @"票据理财";
        _numTitleLb.text = @"10.66%";
        _srcTitleLb.text = @"预期年化收益率";
        _titleLb.text = @"城乡太票据";
        _dayLb.text = @"112天";
        _moneyLb.text = @"5万起投";

        _stateLb.text = @"发行中";
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
