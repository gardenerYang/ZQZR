//
//  BusinessCertificationVC.m
//  ZQZX
//
//  Created by 中企 on 2018/11/3.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BusinessCertificationVC.h"
#import "ZHLoginTextFieldTwoView.h"
#import "HttpRequest+my.h"
#import "SuccessViewController.h"
@interface BusinessCertificationVC ()
@property(nonatomic,strong)ZHLoginTextFieldTwoView *nameTextField;
@property(nonatomic,strong)ZHLoginTextFieldTwoView *cardTextField;
@property(nonatomic,strong)UIView *topLine;
@property(nonatomic,strong)UIView *bottomLine;
@property (strong, nonatomic) UIButton *confirmBtn;

@end

@implementation BusinessCertificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomerTitle:@"实名认证"];
    [self addUI];
}
-(void)addUI{
    __weak typeof(self) wf = self;
    

    _nameTextField=[[ZHLoginTextFieldTwoView alloc]init];
    _nameTextField.TextField.placeholder= @"真实姓名";
    _nameTextField.TextField.text = _myModel.realName.length == 0 ? @"" : _myModel.realName;
    _nameTextField.nameLb.text =  @"请输入真实姓名";
    _nameTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTextField.TextField.keyboardType=UIKeyboardTypeDefault;
    [self.view addSubview:_nameTextField];
    
    _topLine = [[UIView alloc]init];
    _topLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_topLine];
    
    _cardTextField=[[ZHLoginTextFieldTwoView alloc]init];
    _cardTextField.TextField.placeholder= @"身份证号";
    _cardTextField.TextField.text = _myModel.idNo.length == 0 ? @"" : _myModel.idNo;
    _cardTextField.nameLb.text =  @"请输入身份证号";
    _cardTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _cardTextField.TextField.keyboardType=UIKeyboardTypeDefault;
    [self.view addSubview:_cardTextField];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine];
    
    
    
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = kF18;
    _confirmBtn.layer.cornerRadius = 80/4;
    _confirmBtn.backgroundColor = kMainColor;
    [_confirmBtn addAction:^(UIButton *sender) {
        
        if (wf.nameTextField.TextField.text.length <= 0 ) {
            [MBProgressHUD showErrorMessage:@"请输入真实姓名"];
            return;
        }else if (wf.cardTextField.TextField.text.length <= 0){
            [MBProgressHUD showErrorMessage:@"请输入身份证号"];
            return;
        }else if (![wf.cardTextField.TextField.text validationType: ValidationTypeIDCard]){
            [MBProgressHUD showErrorMessage:@"输入的身份证号不正确"];
            return;
        }
        else{
            [MBProgressHUD showActivityMessageInView:nil];
            [HttpRequest getMyauthenticationUserName:wf.nameTextField.TextField.text idNum:wf.cardTextField.TextField.text province:@"" city:@"" contactAddress:@"" Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
                [MBProgressHUD hideHUD];
                SuccessViewController *successVC=[[SuccessViewController alloc]init];
                successVC.titleLbText = @"认证成功";
                successVC.srcLbText = @"即将返回";
                [successVC setOtherblock:^{
                    [wf.navigationController popViewControllerAnimated:YES];
                }];
                [successVC showInVC:wf];
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideHUD];
                SuccessViewController *successVC=[[SuccessViewController alloc]init];
                successVC.titleLbText = @"认证失败";
                successVC.srcLbText = error.localizedDescription;
                successVC.btnTitle = @"返回";
                successVC.btnBgColor = kMainColor;
                successVC.imgName = @"err";
                [successVC setTapBtnblock:^{
                    [successVC dismiss];
                    [wf.navigationController popViewControllerAnimated:YES];
                }];
                [successVC showInVC:wf type:SuccessTypeBtn];
            }];
    }
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
        make.height.mas_equalTo(80/2);
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
