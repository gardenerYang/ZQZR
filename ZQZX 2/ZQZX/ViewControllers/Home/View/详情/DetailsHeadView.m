//
//  DetailsHeadView.m
//  ZQZX
//
//  Created by 中企 on 2018/10/16.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "DetailsHeadView.h"
#import "HeadTextLabel.h"
#import "UIButton+SSEdgeInsets.h"
@implementation DetailsHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI {
    _headView = [[UIView alloc]init];
    [self addSubview:_headView];
    _headImgView = [[UIImageView alloc]init];
    _headImgView.image = [UIImage imageNamed:@"headbg"];
    [_headView addSubview:_headImgView];
    
    _titleLb=[[UILabel alloc]init];
    _titleLb.font = [UIFont boldSystemFontOfSize:40];
    _titleLb.textColor=[UIColor whiteColor];
    _titleLb.textAlignment=NSTextAlignmentCenter;
    [_headImgView addSubview:_titleLb];
    
    _srcLb=[[UILabel alloc]init];
    _srcLb.font = [UIFont s16];
    _srcLb.textColor=[UIColor whiteColor];
    _srcLb.textAlignment=NSTextAlignmentCenter;
    _srcLb.text = @"预期年化收益率";
    [_headImgView addSubview:_srcLb];
    
    _raiseImg = [[UIImageView alloc]init];
    [_headView addSubview:_raiseImg];
    [_raiseImg setImage:kImageNamed(@"jiaxi")];
    _raiseImg.hidden = YES;
    
    _dayView = [[HeadTextLabel alloc]initWithType];
    _dayView.srcLabel.text = @"项目期限";
    [_headView addSubview:_dayView];
    
    _moneyView = [[HeadTextLabel alloc]initWithType];
    _moneyView.srcLabel.text = @"起投金额";
    [_headView addSubview:_moneyView];
    
    _numView = [[HeadTextLabel alloc]initWithType];
    _numView.srcLabel.text = @"目标金额";
    [_headView addSubview:_numView];
    
    _num1View = [[HeadTextLabel alloc]initWithType];
    _num1View.srcLabel.text = @"可预约金额";
    [_headView addSubview:_num1View];
    
        _dayView.srcLabel.font = [UIFont s12];
        _dayView.titleLabel.font = [UIFont s14];
        _moneyView.srcLabel.font = [UIFont s12];
        _moneyView.titleLabel.font = [UIFont s14];
        _numView.srcLabel.font = [UIFont s12];
        _numView.titleLabel.font = [UIFont s14];
        _num1View.srcLabel.font = [UIFont s12];
        _num1View.titleLabel.font = [UIFont s14];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
       make.height.mas_equalTo(self.headImgView.mas_width).multipliedBy(0.52);
    }];
    

    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Iphonewidth * 0.52 *0.35);
        make.centerX.equalTo(self);
        
    }];
    [_raiseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLb).offset(-12);
        make.top.equalTo(self.titleLb).offset(7);

        make.size.mas_equalTo(CGSizeMake(37, 15));
    }];
    [_srcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [_dayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImgView.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(Iphonewidth/4);
        make.bottom.mas_equalTo(-10);
    }];
    [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.dayView);
        make.left.mas_equalTo(self.dayView.mas_right);
        make.width.mas_equalTo(Iphonewidth/4);
        make.height.mas_equalTo(self.dayView);
    }];
    [_numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.dayView);
        make.left.mas_equalTo(self.moneyView.mas_right);
        make.width.mas_equalTo(Iphonewidth/4);
        make.height.mas_equalTo(self.dayView);
    }];
    [_num1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.dayView);
        make.left.mas_equalTo(self.numView.mas_right);
        make.width.mas_equalTo(Iphonewidth/4);
        make.height.mas_equalTo(self.dayView);

    }];
    
    
}
@end
