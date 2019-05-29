//
//  OrderdetailsCell2.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "OrderdetailsCell2.h"

@implementation OrderdetailsCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        
    }
    return self;
}
-(void)addUI{
    self.BKView=[[UIView alloc]init];
    self.BKView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.BKView];
    _car1View = [[OrderTextLabel alloc]initWithType];
    _car1View.titleLabel.text = @"打款银行卡";
    [self.BKView addSubview:_car1View];
    
    _car2View = [[OrderTextLabel alloc]initWithType];
    _car2View.titleLabel.text = @"回款银行卡";
    [self.BKView addSubview:_car2View];
    
    _carPlace2View = [[OrderTextLabel alloc]initWithType];
    _carPlace2View.titleLabel.text = @"回款开户行";
    [self.BKView addSubview:_carPlace2View];
    
    
    _moneyView = [[OrderTextLabel alloc]initWithType];
    _moneyView.titleLabel.text = @"用户打款金额";
    [self.BKView addSubview:_moneyView];
    
    _timeView = [[OrderTextLabel alloc]initWithType];
    _timeView.titleLabel.text = @"用户打款日期";
    [self.BKView addSubview:_timeView];
    [_BKView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    [_car1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    [_car2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.car1View.mas_bottom).offset(5);
        make.left.mas_equalTo(self.car1View);
        make.right.mas_equalTo(self.car1View);
    }];
    
    [_carPlace2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.car2View.mas_bottom).offset(5);
        make.left.mas_equalTo(self.car1View);
        make.right.mas_equalTo(self.car1View);
    }];
    
    
    [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.carPlace2View.mas_bottom).offset(5);
        make.left.mas_equalTo(self.car1View);
        make.right.mas_equalTo(self.car1View);
    }];
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.car1View);
        make.right.mas_equalTo(self.car1View);
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
