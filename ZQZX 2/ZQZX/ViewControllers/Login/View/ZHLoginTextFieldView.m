//
//  ZHLoginTextFieldView.m
//  Ninesecretary
//
//  Created by chenglian on 2017/8/2.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "ZHLoginTextFieldView.h"

@implementation ZHLoginTextFieldView

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
        [self.tFView addSubview:self.TextFieldImageView];
        [self.tFView addSubview:self.TextField];
        
        [self.tFView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(5);
            make.right.mas_equalTo(0);
        }];
        [self.TextFieldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.tFView);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        
        [self.TextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.tFView);
            make.left.mas_equalTo(self.TextFieldImageView.mas_right).offset(10);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(self.tFView);
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


-(UIImageView *)TextFieldImageView
{
    if (!_TextFieldImageView) {
        _TextFieldImageView=[[UIImageView alloc]init];
    }
    return _TextFieldImageView;
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
        _TextField.tintColor = [UIColor m_red];

    }
    return _TextField;
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  [[NSNotificationCenter defaultCenter] postNotificationName:@"inputkeyboard" object:@YES];
    return YES;
}
-(void)isModifyFieldClearBtn{
    UIButton *clean = [_TextField valueForKey:@"_clearButton"]; //key是固定的
    [clean setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    [clean setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateHighlighted];
}
-(void)addCorrectImg{
    _stateImg=[[UIImageView alloc]init];
    _stateImg.image = [UIImage imageNamed:@"Correct"];
    [self.tFView addSubview:_stateImg];
    
    [self.stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.tFView);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.right.mas_equalTo(-30);
    }];
}
-(void)isHiddenPwd{
    
}
-(void)addCorrectImg:(NSString*)imgName{
    _stateImg=[[UIImageView alloc]init];
    _stateImg.image = [UIImage imageNamed:imgName];
    [self.tFView addSubview:_stateImg];
    
    [self.stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.tFView);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.right.mas_equalTo(-30);
    }];
}
-(void)addisHiddenBtn{
    __weak typeof(self) wf = self;
    wf.TextField.secureTextEntry = YES;
    _isHiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_isHiddenBtn setImage:[UIImage imageNamed:@"nodisplay"] forState:UIControlStateNormal];
    [_isHiddenBtn addAction:^(UIButton *sender) {
        
        if (wf.isHiddenBtn.selected) {
            wf.isHiddenBtn.selected = false;
            [wf.isHiddenBtn setImage:[UIImage imageNamed:@"nodisplay"] forState:UIControlStateNormal];
            wf.TextField.secureTextEntry = YES;

            
        }else{
            wf.isHiddenBtn.selected = YES;
            [wf.isHiddenBtn setImage:[UIImage imageNamed:@"display"] forState:UIControlStateNormal];
            wf.TextField.secureTextEntry = NO;
            

        }
    }];
    [self.tFView addSubview:_isHiddenBtn];

    [self.isHiddenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.tFView);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.right.mas_equalTo(-30);
    }];
}

@end
