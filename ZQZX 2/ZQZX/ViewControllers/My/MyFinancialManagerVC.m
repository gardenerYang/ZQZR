//
//  MyFinancialManagerVC.m
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyFinancialManagerVC.h"
#import "FinancialManagerView.h"
#import "TipsViewController.h"
#import "UIViewController+Util.h"
@interface MyFinancialManagerVC ()
@property(nonatomic,strong)FinancialManagerView *nameView;
@property(nonatomic,strong)FinancialManagerView *phoneView;
@property(nonatomic,strong)FinancialManagerView *cityView;

@end

@implementation MyFinancialManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self setCustomerTitle:@"我的理财师"];
    [self addUI];
}
-(void)addUI{
    __weak typeof(self) wf = self;
    _nameView = [[FinancialManagerView alloc]initWithType];
    _nameView.titleLb.text = @"理财师姓名";
    _nameView.nameLb.text = _myModel.lcsRealName;
    [self.view addSubview:_nameView];
    
    _phoneView = [[FinancialManagerView alloc]initWithType];
    _phoneView.titleLb.text = @"理财师电话";
    _phoneView.nameLb.text = _myModel.lcsPhone;
    [self.view addSubview:_phoneView];
    
    _cityView = [[FinancialManagerView alloc]initWithType];
    _cityView.titleLb.text = @"理财师所在城市";
    _cityView.nameLb.text = _myModel.lcsCity;
    [self.view addSubview:_cityView];
    
    UIButton *tellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tellBtn setBackgroundColor:[UIColor m_greenColor]];
    [tellBtn setTitle:@"联系理财师" forState:UIControlStateNormal];
    tellBtn.layer.masksToBounds = YES;
    tellBtn.layer.cornerRadius = 25;
    [tellBtn addAction:^(UIButton *sender) {
        TipsViewController *TipsVC=[[TipsViewController alloc]init];
        TipsVC.titleLbText = @"温馨提示";
        TipsVC.srcLbText = [NSString stringWithFormat:@"电话联系理财师%@",wf.myModel.lcsRealName];
        [TipsVC setTapCancelBtnblock:^{
            
        }];
        [TipsVC setTapConfirmBtnblock:^{
            [wf tel:wf.myModel.lcsPhone];
        }];
        [TipsVC showInVC: wf ];
    }];
    [self.view addSubview:tellBtn];
    
    [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(loginsLeftSpacing);
        make.right.mas_equalTo(loginsRightSpacing);
        make.height.mas_offset(50);
    }];
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameView.mas_bottom);
        make.left.mas_equalTo(self.nameView.mas_left);
        make.right.mas_equalTo(self.nameView.mas_right);
        make.height.mas_offset(50);
    }];
    [_cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneView.mas_bottom);
        make.left.mas_equalTo(self.nameView.mas_left);
        make.right.mas_equalTo(self.nameView.mas_right);
        make.height.mas_offset(50);
    }];

  
    [tellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cityView.mas_bottom).offset(30);
        make.left.mas_equalTo(self.nameView);
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(self.nameView);
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
