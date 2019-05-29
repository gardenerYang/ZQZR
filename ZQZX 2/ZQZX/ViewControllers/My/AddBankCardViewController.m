//
//  AaaBankCardViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "ZHLoginTextFieldTwoView.h"
#import "SuccessViewController.h"
#import "HttpRequest+my.h"
@interface AddBankCardViewController ()
@property(nonatomic,strong)ZHLoginTextFieldTwoView *nameTextField;
@property(nonatomic,strong)ZHLoginTextFieldTwoView *cardTextField;
@property(nonatomic,strong)UIView *topLine;
@property(nonatomic,strong)UIView *bottomLine;
@property (strong, nonatomic) UIButton *confirmBtn;
@end

@implementation AddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setCustomerTitle:@"添加银行卡"];
    [self addUI];
}
-(void)addUI{
    __weak typeof(self) wf = self;
    
    NSString *realName;
    if (wf.realName .length == 0) {
        if (wf.myModel.realName.length == 0) {
            realName = @"";
        }else{
            realName = wf.myModel.realName;
        }
    }else{
        realName = wf.realName;
    }
    _nameTextField=[[ZHLoginTextFieldTwoView alloc]init];
    _nameTextField.TextField.placeholder= @"持卡人";
    _nameTextField.TextField.text = realName ;
    _nameTextField.nameLb.text = @"请输入持卡人" ;
    if (realName.length == 0) {
        _nameTextField.TextField.userInteractionEnabled = NO;
    }
    _nameTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTextField.TextField.keyboardType=UIKeyboardTypeDefault;
    [self.view addSubview:_nameTextField];
    
    _topLine = [[UIView alloc]init];
    _topLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_topLine];
    
    _cardTextField=[[ZHLoginTextFieldTwoView alloc]init];
    _cardTextField.TextField.placeholder= @"请输入银行卡号";
    _cardTextField.nameLb.text = @"卡号";
    _cardTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _cardTextField.TextField.keyboardType=UIKeyboardTypeDefault;
    [self.view addSubview:_cardTextField];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"绑卡" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont s20];
    _confirmBtn.layer.cornerRadius = 25.0;
    _confirmBtn.backgroundColor = [UIColor m_red];
    [_confirmBtn addAction:^(UIButton *sender) {
        [MBProgressHUD showActivityMessageInView:nil];
        [wf.nameTextField.TextField resignFirstResponder];
        [wf.cardTextField.TextField resignFirstResponder];
        wf.confirmBtn.userInteractionEnabled = NO;
        NSString *idNos;
        if (wf.idNo .length == 0) {
            if (wf.myModel.idNo.length == 0) {
                idNos = @"";
            }else{
             idNos = wf.myModel.idNo;
            }
        }else{
            idNos = wf.idNo;
        }
        NSString * userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        [HttpRequest addCardName:wf.nameTextField.TextField.text idNum:idNos mobile:userName cardNo:wf.cardTextField.TextField.text username:userName Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
            [MBProgressHUD hideHUD];
            wf.confirmBtn.userInteractionEnabled = YES;

            SuccessViewController *successVC=[[SuccessViewController alloc]init];
            successVC.titleLbText = @"温馨提示";
            successVC.srcLbText = @"恭喜您成功绑定银行卡";
            successVC.btnTitle = @"确定";
            successVC.btnBgColor = [UIColor m_Lightred];
            [successVC setTapBtnblock:^{
                [wf.navigationController popViewControllerAnimated:YES];
            }];
            [successVC showInVC:wf type:SuccessTypeBtn];
        } failure:^(NSError * _Nonnull error) {
            wf.confirmBtn.userInteractionEnabled = YES;

                  [MBProgressHUD hideHUD];
                    SuccessViewController *successVC=[[SuccessViewController alloc]init];
                    successVC.titleLbText = @"温馨提示";
                    successVC.srcLbText = error.localizedDescription;
                    successVC.btnTitle = @"确定";
                    successVC.btnBgColor = [UIColor m_blue];
                    successVC.imgName = @"err";

                    [successVC setTapBtnblock:^{
                        [successVC dismiss];
                    }];
                    [successVC showInVC:wf type:SuccessTypeBtn];
        }];
        
    }];
    [self.view addSubview:_confirmBtn];
    
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(60);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTextField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.nameTextField);
        make.right.mas_equalTo(self.nameTextField);
        make.height.mas_equalTo(1);
    }];
    [self.cardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.topLine);
        make.right.mas_equalTo(self.topLine);
        make.height.mas_equalTo(self.nameTextField);
    }];
    
    
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cardTextField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.cardTextField);
        make.right.mas_equalTo(self.cardTextField);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(20);
        make.left.mas_equalTo(self.cardTextField).offset(10);
        make.right.mas_equalTo(self.cardTextField);
        make.height.mas_equalTo(50);
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
