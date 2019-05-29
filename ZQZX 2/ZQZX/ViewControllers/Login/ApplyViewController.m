//
//  ApplyViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/12.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ApplyViewController.h"
#import "ZHLoginTextFieldTwoView.h"
#import "SkyerCityPicker.h"
#import "CityPickerViewController.h"
#import "SuccessViewController.h"
#import "HttpRequest+loginAndRegister.h"

@interface ApplyViewController ()
@property(nonatomic,strong)ZHLoginTextFieldTwoView *nameField;
@property(nonatomic,strong)ZHLoginTextFieldTwoView *phoneField;
@property(nonatomic,strong)ZHLoginTextFieldTwoView *cityField;
@property(nonatomic,strong)ZHLoginTextFieldTwoView *addressField;

@property(nonatomic,strong)UIView *topLine;
@property(nonatomic,strong)UIView *middleLine;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)UIView *bottomLine1;


@property(nonatomic,strong)UIButton *applyBtn;
@property(nonatomic,strong)UIButton *selectCityBtn;
@property(nonatomic,strong)NSString *cityStr;//市
@property(nonatomic,strong)NSString *provinceStr;//省

@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupForDismissKeyboard];
    [self setCustomerTitle:@"申请理财师"];
    [self addUI];

}
-(void)addUI{
    __weak typeof(self) wf = self;
    _nameField=[[ZHLoginTextFieldTwoView alloc]init];
    _nameField.TextField.placeholder= @"请输入姓名";
    _nameField.nameLb.text = @"姓名";
    _nameField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameField.TextField.keyboardType=UIKeyboardTypeDefault;
    [self.view addSubview:_nameField];
    
    _topLine = [[UIView alloc]init];
    _topLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_topLine];
    
    _phoneField=[[ZHLoginTextFieldTwoView alloc]init];
    _phoneField.TextField.placeholder= @"请输入手机号码";
    _phoneField.nameLb.text = @"手机号";
    _phoneField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneField.TextField.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneField];
    
    _middleLine = [[UIView alloc]init];
    _middleLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_middleLine];
    
    _cityField=[[ZHLoginTextFieldTwoView alloc]init];
    _cityField.TextField.placeholder= @"请选择所在城市";
    _cityField.nameLb.text = @"所在城市";
    _cityField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _cityField.TextField.userInteractionEnabled = NO;
    [self.view addSubview:_cityField];
    
    
    
    _selectCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectCityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_selectCityBtn setImage:[UIImage imageNamed:@"selectCity_bottom"] forState:UIControlStateNormal];
    [_selectCityBtn addAction:^(UIButton *sender) {
        
        SkyerCityPicker *skyerCityPicker=[[SkyerCityPicker alloc] init];
        [skyerCityPicker cityPikerGetSelectCity:^(NSMutableDictionary *dicSelectCity) {
            NSLog(@"dicSelectCity=%@",dicSelectCity);
            NSString *cityText = [NSString stringWithFormat:@"%@%@%@",dicSelectCity[@"Province"],dicSelectCity[@"City"],dicSelectCity[@"District"]];
            wf.cityStr = dicSelectCity[@"City"];
            wf.provinceStr = dicSelectCity[@"Province"];
            wf.cityField.TextField.text = cityText;
        }];
        
    }];
    [self.view addSubview:_selectCityBtn];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine];
    
    
    
    
    _addressField=[[ZHLoginTextFieldTwoView alloc]init];
    _addressField.TextField.placeholder= @"请输入通讯地址";
    _addressField.nameLb.text = @"通讯地址";
    _addressField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_addressField];
    
    _bottomLine1 = [[UIView alloc]init];
    _bottomLine1.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine1];
    
    
    
    
    _applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_applyBtn setTitle:@"申请" forState:UIControlStateNormal];
    [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _applyBtn.titleLabel.font = [UIFont s20];
    _applyBtn.layer.cornerRadius = 25.0;
    _applyBtn.backgroundColor = [UIColor m_red];
    [_applyBtn addAction:^(UIButton *sender) {
        if (wf.nameField.TextField.text.length <= 0 ) {
            [MBProgressHUD showErrorMessage:@"请输入姓名"];
            return;
        }else if (wf.phoneField.TextField.text.length <= 0 ){
            [MBProgressHUD showErrorMessage:@"请输入手机号"];
            return;
        }else if (wf.provinceStr.length <= 0 ){
            [MBProgressHUD showErrorMessage:@"请选择城市"];
            return;
        } else if (wf.addressField.TextField.text.length <= 0 ){
            [MBProgressHUD showErrorMessage:@"请输入通讯地址"];
            return;
        }else{
        [MBProgressHUD showActivityMessageInView:nil];
        [HttpRequest ApplyFinancialManager:wf.nameField.TextField.text phone:wf.phoneField.TextField.text province:wf.provinceStr city:wf.cityStr address:wf.addressField.TextField.text Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
            [MBProgressHUD hideHUD];
            
            SuccessViewController *successVC=[[SuccessViewController alloc]init];
            successVC.titleLbText = @"申请成功";
            successVC.srcLbText = @"您的理财师会尽快联系您";
            [successVC showInVC:wf];
            [successVC setOtherblock:^{
                [wf.navigationController popToRootViewControllerAnimated:YES];
            }];

        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD showErrorMessage:error.localizedDescription];

        }];
        }
    

    }];
    [self.view addSubview:_applyBtn];
    
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.mas_equalTo(loginsLeftSpacing);
        make.right.mas_equalTo(loginsRightSpacing);
        make.height.mas_equalTo(60);
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.nameField);
        make.right.mas_equalTo(self.nameField);
        make.height.mas_equalTo(1);
    }];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.topLine);
        make.right.mas_equalTo(self.topLine);
        make.height.mas_equalTo(60);
    }];
    [self.middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.phoneField);
        make.right.mas_equalTo(self.phoneField);
        make.height.mas_equalTo(1);
    }];
    
    [self.cityField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.middleLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.middleLine);
        make.right.mas_equalTo(self.middleLine);
        make.height.mas_equalTo(60);
    }];
    [self.selectCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomLine.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(self.middleLine);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cityField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.cityField);
        make.right.mas_equalTo(self.cityField);
        make.height.mas_equalTo(1);
    }];
    [self.addressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bottomLine);
        make.right.mas_equalTo(self.bottomLine);
        make.height.mas_equalTo(60);
    }];
    [self.bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.addressField);
        make.right.mas_equalTo(self.addressField);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLine1.mas_bottom).offset(30);
        make.left.mas_equalTo(self.bottomLine1);
        make.right.mas_equalTo(self.bottomLine1);
        make.height.mas_equalTo(50);
    }];
    
    [self addBottomIMG];
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
