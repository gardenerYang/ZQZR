//
//  MyBusinessOrderdetailsCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/24.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyBusinessOrderdetailsCell.h"

@implementation MyBusinessOrderdetailsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _titleLb=[[UILabel alloc]init];
    _titleLb.font = [UIFont s16];
    _titleLb.textColor=kTitleColor;
    _titleLb.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_titleLb];
    
    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.delegate = self;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.leftViewMode=UITextFieldViewModeAlways;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.placeholder=@"";
    _textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _textField.font=[UIFont s16];
    [_textField setValue:[UIColor m_textLighGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _textField.tintColor = kMainColor;
    [self addSubview:_textField];

    _jianImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    [self addSubview:_jianImg];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor m_lineColor];
    [self addSubview:_lineView];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(40);
    }];
    [_jianImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.textField);
        make.size.mas_equalTo(CGSizeMake(10, 17));
        make.right.mas_equalTo(-10);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(-1);
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
