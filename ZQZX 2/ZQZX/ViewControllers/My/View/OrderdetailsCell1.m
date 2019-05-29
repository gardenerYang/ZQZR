//
//  OrderdetailsCell1.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "OrderdetailsCell1.h"

@implementation OrderdetailsCell1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        self.backgroundColor = [UIColor m_gray];
        self.selectionStyle = NO;
        
    }
    return self;
}
-(void)addUI{
    
    _orderNumLb=[[UILabel alloc]init];
    _orderNumLb.font = [UIFont s14];
    _orderNumLb.textColor=[UIColor m_textDeepGrayColor];
    _orderNumLb.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_orderNumLb];
    
    self.BKView=[[UIView alloc]init];
    self.BKView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.BKView];
    
    _titleLb=[[UILabel alloc]init];
    _titleLb.font = [UIFont s16];
    _titleLb.textColor=[UIColor blackColor];
    _titleLb.textAlignment=NSTextAlignmentLeft;
    [self.BKView addSubview:_titleLb];
    
    _tagLb=[[UILabel alloc]init];
    _tagLb.font = [UIFont s12];
    _tagLb.textColor=[UIColor m_red];
    _tagLb.textAlignment=NSTextAlignmentCenter;
    _tagLb.layer.borderColor = [UIColor m_red].CGColor;
    _tagLb.layer.borderWidth = 1;
    _tagLb.layer.masksToBounds = YES;
    _tagLb.layer.cornerRadius = 5;
    [self.BKView addSubview:_tagLb];
//    UIImageView * arrowImg = [[UIImageView alloc]initWithImage:kImageNamed(@"arrow")];
//    [self.BKView addSubview:arrowImg];
    
    _numView = [[OrderTextLabel alloc]initWithType];
    _numView.titleLabel.text = @"预期年化收益率";
    [self.BKView addSubview:_numView];

    _moneyView = [[OrderTextLabel alloc]initWithType];
    _moneyView.titleLabel.text = @"预约金额";
    [self.BKView addSubview:_moneyView];
    
    _deadlineView = [[OrderTextLabel alloc]initWithType];
    _deadlineView.titleLabel.text = @"项目期限";
    [self.BKView addSubview:_deadlineView];
    
    _timeView = [[OrderTextLabel alloc]initWithType];
    _timeView.titleLabel.text = @"订单时间";
    [self.BKView addSubview:_timeView];
    
    _stateView = [[OrderTextLabel alloc]initWithType];
    _stateView.titleLabel.text = @"订单状态";
    [self.BKView addSubview:_stateView];
    
    _nameView = [[OrderTextLabel alloc]initWithType];
    _nameView.titleLabel.text = @"用户姓名";
    [self.BKView addSubview:_nameView];
    
    _phoneiew = [[OrderTextLabel alloc]initWithType];
    _phoneiew.titleLabel.text = @"手机号码";
    [self.BKView addSubview:_phoneiew];
    [_orderNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
    }];
    
    [_BKView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumLb.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-100);
    }];
    [_tagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLb);
        make.width.mas_equalTo(90);
        make.right.mas_equalTo(-10);
    }];

    [_numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(5);
        make.left.mas_equalTo(self.titleLb);
        make.right.mas_equalTo(0);
    }];
//    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-10);
//        make.centerY.equalTo(self.numView);
//        make.size.mas_equalTo(CGSizeMake(5, 9));
//    }];
    [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.numView);
        make.right.mas_equalTo(0);
    }];
    [_deadlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.numView);
        make.right.mas_equalTo(0);
    }];
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.deadlineView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.numView);
        make.right.mas_equalTo(self.moneyView);
    }];
    [_stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.numView);
        make.right.mas_equalTo(self.moneyView);
    }];
    [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stateView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.numView);
        make.right.mas_equalTo(self.moneyView);
    }];
    [_phoneiew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.numView);
        make.right.mas_equalTo(self.moneyView);
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
