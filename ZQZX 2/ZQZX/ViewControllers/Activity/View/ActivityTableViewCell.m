//
//  ActivityTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        
    }
    return self;
}
-(void)addUI{
    self.BKView=[[UIView alloc]init];
    self.BKView.backgroundColor=[UIColor whiteColor];
    self.BKView.layer.shadowOffset =  CGSizeMake(1,10);
    self.BKView.layer.shadowOpacity = 0.6;
    self.BKView.layer.shadowColor =  [UIColor m_textLighGrayColor].CGColor;
//   self.BKView.layer.masksToBounds = YES;
    self.BKView.layer.cornerRadius = 5;
//    self.BKView.backgroundColor =[UIColor greenColor];
    [self addSubview:self.BKView];
    
    _bgimgView = [[UIImageView alloc]init];
    _bgimgView.backgroundColor = [UIColor m_red];
    [_BKView addSubview:_bgimgView];
    
    _titleLb=[[UILabel alloc]init];
    _titleLb.font = [UIFont s16];
    _titleLb.textColor=kTitleColor;
    _titleLb.textAlignment=NSTextAlignmentLeft;
    [_BKView addSubview:_titleLb];
    
   

    
    [_BKView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
    
    [_bgimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(self.bgimgView.mas_width).multipliedBy(0.46);
    }];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgimgView.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
   
    
}
-(void)isStatelayout{
    
    _srcLb=[[UILabel alloc]init];
    _srcLb.font = [UIFont s14];
    _srcLb.textColor=[UIColor m_textDeepGrayColor];
    _srcLb.textAlignment=NSTextAlignmentLeft;
    _srcLb.text= @"距离活动结束还有";
    [_BKView addSubview:_srcLb];
    
    
    
    
    _config = [[HSFTimeDownConfig alloc]init];
    //        config.timeType = HSFTimeType_HOUR_MINUTE;
    _config.bgColor = [UIColor withHexStr:@"#4f5051"];
    _config.fontColor = [UIColor withHexStr:@"#fffb00"];
    _config.fontSize = 19.f;
    _config.fontColor_placeholder = [UIColor m_textDeepGrayColor];
    _config.fontSize_placeholder = 14.f;
    _timeLabel_hsf = [[HSFTimeDownView alloc] initWityFrame:CGRectMake(0, 100, 200, 20) config:_config timeChange:^(NSInteger time) {
        //        NSLog(@"hsf===%ld",(long)time);
    } timeEnd:^{
        //      NSLog(@"hsf===倒计时结束");
    }];
    
    [_BKView addSubview:_timeLabel_hsf];
    
    [_titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgimgView.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [_srcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(120);
        make.bottom.mas_offset(-10);
    }];
    
    [_timeLabel_hsf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(10);
        make.left.mas_equalTo(self.srcLb.mas_right).offset(0);
        make.width.mas_equalTo(200);
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
