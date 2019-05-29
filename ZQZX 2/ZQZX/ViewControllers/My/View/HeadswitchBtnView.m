//
//  HeadswitchBtnView.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HeadswitchBtnView.h"

@implementation HeadswitchBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithType{
    self = [super init];
    
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI {
    __weak typeof(self) wf = self;

       _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"" forState:UIControlStateNormal];
        _leftBtn.layer.borderColor = [UIColor m_Lightred].CGColor;
        _leftBtn.layer.borderWidth = 1;
        _leftBtn.titleLabel.font = [UIFont s14];
        [self addSubview:_leftBtn];
    
    
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(loginsLeftSpacing);
            make.height.mas_equalTo(44);
            make.right.mas_equalTo(self.mas_centerX);
        }];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.layer.borderColor = [UIColor m_Lightred].CGColor;
    _rightBtn.layer.borderWidth = 1;
    _rightBtn.titleLabel.font = [UIFont s14];
    
    [self addSubview:_rightBtn];
    wf.leftBtn.backgroundColor = [UIColor m_Lightred];
    [wf.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    wf.rightBtn.backgroundColor = [UIColor whiteColor];
    [wf.rightBtn setTitleColor:[UIColor m_Lightred] forState:UIControlStateNormal];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftBtn);
        make.left.mas_equalTo(self.leftBtn.mas_right);
        make.height.mas_equalTo(self.leftBtn);
        make.right.mas_equalTo(loginsRightSpacing);
    }];
    _leftBtn.selected = YES;
    _rightBtn.selected = NO;
    [_leftBtn addAction:^(UIButton *sender) {
        wf.leftBtn.backgroundColor = [UIColor m_Lightred];
        [wf.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        wf.rightBtn.backgroundColor = [UIColor whiteColor];
        [wf.rightBtn setTitleColor:[UIColor m_Lightred] forState:UIControlStateNormal];
        if (wf.tapLeftBtnblock) {
            wf.tapLeftBtnblock();
        }
    }];
    [_rightBtn addAction:^(UIButton *sender) {
        wf.rightBtn.backgroundColor = [UIColor m_Lightred];
        [wf.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        wf.leftBtn.backgroundColor = [UIColor whiteColor];
        [wf.leftBtn setTitleColor:[UIColor m_Lightred] forState:UIControlStateNormal];
        if (wf.tapRightBtnblock) {
            wf.tapRightBtnblock();
        }
    }];
    
  
}
-(void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    [_leftBtn setTitle:_leftTitle forState:UIControlStateNormal];
    
}
-(void)setRightTitle:(NSString *)rightTitle{
    _rightTitle = rightTitle;
    [_rightBtn setTitle:_rightTitle forState:UIControlStateNormal];
}
@end
