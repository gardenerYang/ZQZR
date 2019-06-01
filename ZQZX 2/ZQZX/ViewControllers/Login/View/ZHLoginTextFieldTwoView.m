//
//  ZHLoginTextFieldTwoView.m
//  ZQZX
//
//  Created by 中企 on 2018/10/11.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHLoginTextFieldTwoView.h"

@implementation ZHLoginTextFieldTwoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tFView];
        [self.tFView addSubview:self.nameLb];
        [self.tFView addSubview:self.TextField];
        
        [self.tFView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tFView.mas_top).offset(5);
            make.left.equalTo(self.tFView.mas_left).offset(10);
            make.right.equalTo(self.tFView.mas_right).offset(-10);
//            make.height.mas_equalTo(20);
        }];

        [self.TextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLb);
            make.right.mas_equalTo(self.nameLb);
            make.top.mas_equalTo(self.nameLb.mas_bottom).offset(10);
            make.bottom.mas_equalTo(self.tFView.mas_bottom).offset(-5);
        }];
        
    }
    return self;
}

- (UIView *)tFView {
    
    if (_tFView == nil) {
        _tFView = [[UIView alloc] init];
        _tFView.layer.borderColor = [UIColor whiteColor].CGColor;
        _tFView.layer.borderWidth = 1;
        _tFView.layer.masksToBounds = YES;
        _tFView.layer.cornerRadius = 5;
        
    }
    return _tFView;
}


-(UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb=[[UILabel alloc]init];
        _nameLb.textColor = kTitleColor;
        _nameLb.font = [UIFont s16];
    }
    return _nameLb;
}
-(UITextField *)TextField
{
    if (!_TextField) {
        _TextField = [[ZHNoPasteTextField alloc] init];
        _TextField.backgroundColor = [UIColor clearColor];
        _TextField.delegate = self;
        _TextField.borderStyle = UITextBorderStyleNone;
        _TextField.returnKeyType = UIReturnKeyDone;
        _TextField.leftViewMode=UITextFieldViewModeAlways;
        _TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _TextField.placeholder=@"";
        _TextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _TextField.font=[UIFont s16];
        [_TextField setValue:[UIColor m_textLighGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        _TextField.tintColor = kMainColor;
        
    }
    return _TextField;
}
-(void)isModifyFieldClearBtn{
    UIButton *clean = [_TextField valueForKey:@"_clearButton"]; //key是固定的
    [clean setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    [clean setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateHighlighted];
}
@end
