//
//  MyViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyViewController.h"
#import "MyNavView.h"
#import "MyHeadView.h"
#import "MyTableViewCell.h"
#import "HomeButtonTableViewCell.h"
#import "CertificationViewController.h"
#import "SetUpViewController.h"
#import "BankCardViewController.h"
#import "MyFinancialManagerVC.h"
#import "CapitalRecordViewController.h"
#import "MyOrderViewController.h"
#import "ReimbursementplanVC.h"
#import "MymessageViewController.h"
#import "HttpRequest+my.h"
#import "MyModel.h"
#import "NSString+Validation.h"
#import "TipsViewController.h"
#import "SZQuestionCheckBox.h"
#import "AppUserProfile.h"
#import "QAModel.h"
#import "InvestorConfirmation.h"
#import "EvaluationResultsVC.h"
@interface MyViewController ()
@property(nonatomic,strong)  MyNavView *navView;
@property(nonatomic,strong)  MyHeadView *headView;
@property(nonatomic,strong)  NSArray *imgArr;
@property(nonatomic,strong)  NSArray *titleArr;
@property(nonatomic,strong)  MyModel *myModel;
@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) NSMutableArray *optionArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *typeArray;


@property (nonatomic, strong) SZQuestionCheckBox *questionBox;


@end

@implementation MyViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self ZHNavigationBarHidden:YES];
    [self getMyInformation];//获取个人信息
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self ZHNavigationBarHidden:NO];
}

-(void)getMyInformation{
    __weak typeof(self) wf = self;

    [HttpRequest getMyInformationRequestsuccess:^(MyModel * _Nonnull myModel, NSString * _Nonnull message) {
        
        wf.myModel = myModel;
        [wf.tableView reloadData];

        wf.navView.nameLb.text = [self phone:myModel.phone];
        [wf.navView.photoImg sd_setImageWithString:myModel.headPortraitUrl];
        [[NSUserDefaults standardUserDefaults] setObject:myModel.userName forKey:@"userName"];
        wf.headView.moneyLb.text = [NSString stringWithFormat:@"%.2f",myModel.amountTotalInvestment.floatValue]; ;
        wf.headView.money1Lb.text = [NSString stringWithFormat:@"%.2f",myModel.incomeCollecting.floatValue] ;
        wf.headView.money2Lb.text = [NSString stringWithFormat:@"%.2f",myModel.incomeCollected.floatValue];
    } failure:^(NSError * _Nonnull error) {
        if ([error.localizedDescription isEqualToString:@"请先登录"]) {
            
        }else
        {
         [MBProgressHUD showErrorMessage:error.localizedDescription];
        }
    }];
}
- (void)loginback:(NSNotification *)notification
{
    self.tabBarController.selectedIndex = 0;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginback:)
                                                 name:Loginback
                                               object:nil];
    _imgArr = [NSArray arrayWithObjects:@"my_list_a",@"my_list_b",@"my_list_d",@"my_list_e", nil];
    _titleArr = [NSArray arrayWithObjects:@"实名认证",@"绑定银行卡",@"风险评测",@"合格投资者",nil];

    [self addUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTabIndex) name:@"setTabIndex" object:nil];
    
}
- (void)setTabIndex{
    self.tabBarController.selectedIndex = 0;
}
//确认合格投资者
- (void)InvestorConfirmationSuccess{
    
}
-(void)addUI{
    __weak typeof(self) wf = self;

    _navView = [[MyNavView alloc]initWithType];
    [self.view addSubview:_navView];
    [_navView setTapBtnblock:^{
        SetUpViewController *setupVc =[[SetUpViewController alloc]init];
        setupVc.myModel = wf.myModel;

        [wf.navigationController pushViewController:setupVc animated:YES];
    }];
    
    [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(StatusBarHight + NavHeight);
    }];
    
    [self setTableViewEdges:UIEdgeInsetsMake(StatusBarHight + NavHeight, 0, 0, 0)];
    [self.tableView registerClass:[HomeButtonTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeButtonTableViewCell class])];
    [self addHeaderView];
}
- (void)addHeaderView {
    _headView = [[MyHeadView alloc]initWithFrame:CGRectMake(0, 100, Iphonewidth, Iphonewidth/2+10)];
    _headView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = _headView;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSArray *titleArr = [NSArray arrayWithObjects:@"资金记录",@"我的订单",@"回款计划",@"我的信息", nil];
        NSArray *selectArr = [NSArray arrayWithObjects:@"my_a1",@"my_b1",@"my_c",@"my_d", nil];
        NSArray *noselectArr = [NSArray arrayWithObjects:@"my_a1",@"my_b1",@"my_c",@"my_d", nil];
        HomeButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeButtonTableViewCell class]) forIndexPath:indexPath];
        cell.backgroundColor=[UIColor m_bgColor];
        [cell setBtnTitle:titleArr selectImgArr:selectArr imgArr:noselectArr color:[UIColor m_textDeepGrayColor]];
        __weak typeof(self) wf = self;

        [cell setBtnClickBlock:^(NSUInteger selectClick) {
            if (selectClick == 0) {
                CapitalRecordViewController *CapitalRecordVC = [[CapitalRecordViewController alloc]init];
                [wf.navigationController pushViewController:CapitalRecordVC animated:YES];
            }
           else if (selectClick == 1) {
                MyOrderViewController *orderVC = [[MyOrderViewController alloc]init];
                [wf.navigationController pushViewController:orderVC animated:YES];

            }
            else if (selectClick == 2) {
                ReimbursementplanVC *planVC =[[ReimbursementplanVC alloc]init];
                [wf.navigationController pushViewController:planVC animated:YES];

            }
            else{
                if ( @(wf.myModel.realNameStatus).intValue == 1  ) {//实名认证通过
                    if (@(wf.myModel.bankStatus).intValue == 1) {//是否绑定银行卡
                        TipsViewController *TipsVC=[[TipsViewController alloc]init];
                        TipsVC.titleLbText = @"温馨提示";
                        TipsVC.srcLbText = @"您还没有绑定银行卡,去绑定银行卡";
                        [TipsVC setTapCancelBtnblock:^{
                            
                        }];
                        [TipsVC setTapConfirmBtnblock:^{
                            BankCardViewController * BankCardVC = [[BankCardViewController alloc]init];
                            BankCardVC.myModel = wf.myModel;
                            [wf.navigationController pushViewController:BankCardVC animated:YES];
                        }];
                        [TipsVC showInVC: self ];
                    }
                    else{//已经认证和绑卡
                        MymessageViewController *messageVC = [[MymessageViewController alloc]init];
                        messageVC.myModel = wf.myModel;
                        [wf.navigationController pushViewController:messageVC animated:YES];
                    }
                }
                else{
                    TipsViewController *TipsVC=[[TipsViewController alloc]init];
                    TipsVC.titleLbText = @"温馨提示";
                    TipsVC.srcLbText = @"您还没有实名认证,去实名认证";
                    [TipsVC setTapCancelBtnblock:^{
                        
                    }];
                    [TipsVC setTapConfirmBtnblock:^{
                        CertificationViewController *CertificationVC = [[CertificationViewController alloc]init];
                        CertificationVC.myModel = wf.myModel;
                        [wf.navigationController pushViewController:CertificationVC animated:YES];
                    }];
                    [TipsVC showInVC: self ];
      
                }

            }
        }];


        return cell;
    }else{
         static NSString *CellIdentifier = @"Cell";
    MyTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier type:cellTypeImg];
                }
        cell.titleLb.text = _titleArr[indexPath.row];
        cell.headImg.image = [UIImage imageNamed:_imgArr[indexPath.row]];
        if (indexPath.row == 0) {
            if ( @(_myModel.realNameStatus).intValue == 1  ) {//实名认证通过
                cell.srcLb.text = @"已认证";
            }else{
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.srcLb.text = @"未认证";
            }
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 4) {
            if (_myModel.investorConfirm.intValue == 1  ) {//投资者认证通过
                cell.srcLb.text = @"已确认";
                cell.accessoryType = UITableViewCellAccessoryNone;

            }else{
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        return cell;
    }
 
}

//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return ;
    }
    switch (indexPath.row) {
        case 0:{
            if ( @(_myModel.realNameStatus).intValue == 1  ) {
                return;
            }
            CertificationViewController *CertificationVC = [[CertificationViewController alloc]init];
            CertificationVC.myModel = _myModel;
            [self.navigationController pushViewController:CertificationVC animated:YES];
        }
            break;
        case 1:{
            BankCardViewController * BankCardVC = [[BankCardViewController alloc]init];
            BankCardVC.myModel = _myModel;
            [self.navigationController pushViewController:BankCardVC animated:YES];
        }
            break;
        case 2:{
            self.titleArray = [NSMutableArray array];
            self.optionArray = [NSMutableArray array];
            self.dataArray = [NSMutableArray array];
            self.typeArray = [NSMutableArray array];
                //    __weak typeof(self) wf = self;
                if (![AppUserProfile sharedInstance].isLogon) {
                    return;
                }
            if (self.myModel.isQuestionDone.integerValue ==1) {
                EvaluationResultsVC * vc = [[EvaluationResultsVC alloc]init];
                vc.isQuestionDone = YES;
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
            [MBProgressHUD showActivityMessageInView:@"正在请求"];
                [HttpRequest getQuestionList:[AppUserProfile sharedInstance].userId Requestsuccess:^(NSMutableArray * _Nonnull data, NSString * _Nonnull message) {
                    [MBProgressHUD hideHUD];
                    for (QAModel * model in data) {
                        [self.titleArray addObject:model.content];
                        [self.optionArray addObject:model.investAnswers];
                        [self.dataArray addObject:model];
                        [self.typeArray addObject:model.type];
                    }
               
                    SZQuestionItem *item = [[SZQuestionItem alloc] initWithTitleArray:self.titleArray andOptionArray:self.optionArray  andResultArray:nil andQuestonTypes:self.typeArray];
                    self.questionBox = [[SZQuestionCheckBox alloc] initWithItem:item];
                    self.questionBox.dataArray = self.dataArray;
                    [self.navigationController pushViewController:self.questionBox animated:YES];
                } failure:^(NSError * _Nonnull error) {
                    [MBProgressHUD showErrorMessage:error.localizedDescription];
                }];

        }
            break;
        case 3:{
            if (self.myModel.investorConfirm.integerValue==0) {
                InvestorConfirmation * vc = [[InvestorConfirmation alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;

        default:
        {
            TipsViewController *TipsVC=[[TipsViewController alloc]init];
            TipsVC.titleLbText = @"温馨提示";
            TipsVC.srcLbText = @"此功能暂未开放,敬请期待";
            [TipsVC setTapCancelBtnblock:^{
                
            }];
            [TipsVC setTapConfirmBtnblock:^{
               
            }];
            [TipsVC showInVC: self ];
        }
            break;
    }
}


@end
