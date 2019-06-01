//
//  InvestmentdetailsVC.m
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "InvestmentdetailsVC.h"
#import "FrankDefineHeader.h"
#import <MJRefresh/UIScrollView+MJRefresh.h>
#import "DetailsBottomView.h"
#import "SuccessViewController.h"
#import "ProjectTableViewCell.h"
#import "ExamineCollectionViewCell.h"
#import "RecordListTableViewCell.h"
#import "DetailsTableViewCell.h"
#import "DetailsHeadView.h"
#import "ExamineTableViewCell.h"
#import "HttpRequest+Home.h"
#import "ProductDetailsModel.h"
#import "DetailsTwoTableViewCell.h"
#import "AppUserProfile.h"
#import "TipsViewController.h"
#import "CertificationViewController.h"//去实名
#import "BankCardViewController.h"//去绑卡
#import "TicketInformationVC.h"
#import "TicketInfomationCell.h"
#import "HZPhotoBrowser.h"
#import "detailWebviewCell.h"
#import "ActivityWebViewVC.h"
#import "ProductDetailsModel.h"
@interface InvestmentdetailsVC ()<FrankDetailDropDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) FrankDropBounsView * dropView;
@property (nonatomic, strong) DetailsBottomView *bottomView ;

@property (nonatomic, strong) UITableView                   *topTableView;
@property (nonatomic, strong) UITableView                   *bottom1TableView;
@property (nonatomic, strong) UITableView                   *bottom2TableView;
@property (nonatomic, strong) UITableView                   *bottom3TableView;
@property (nonatomic, strong) UITableView                   *bottom4TableView;

@property (nonatomic, assign) NSInteger                   selectIndex;//点击的那一个
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSArray *data1Arr;
@property(nonatomic,strong)NSArray *ticketArr;

@property(nonatomic,strong)ProductDetailsModel *detailsModel;
@property(nonatomic,strong)DetailsHeadView *detailsHeadView;
@property(nonatomic,strong)NSArray *recordArr;//记录列表
@property(nonatomic,assign)CGFloat money;//预约金额
@property(nonatomic,strong)UIWebView * bottomWebview;


@end

@implementation InvestmentdetailsVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 消除导航影响
    [self.dropView viewControllerWillAppear];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 消除导航影响
    [self.dropView viewControllerWillDisappear];
}
- (void)viewDidLoad {
    [super viewDidLoad];

   [self.view addSubview:self.dropView];
#if BusinessTag
    
#else
    if (@(_status).intValue == 1) {
        [self.view addSubview:self.bottomView];

    }
#endif
    [self addHeaderView];
    [self getProductDetails];//获取详情
    [self getRecordlist];//获取预约记录
    [self getTicketInfomation];
}
-(void)addHeaderView{
   _detailsHeadView = [[DetailsHeadView alloc]initWithFrame:CGRectMake(0, 0, Iphonewidth, Iphonewidth *0.52 + 80)];
    self.topTableView.tableHeaderView = _detailsHeadView;
}

/**
 获取详情
 */
-(void)getProductDetails{
    __weak typeof(self)wf = self;
    [MBProgressHUD showActivityMessageInView:nil];
//票据直投
    [HttpRequest getHomeListDetailsID:self.productID Requestsuccess:^(ProductDetailsModel * _Nonnull model, NSString * _Nonnull message) {
        wf.detailsModel = model;
        NSString * purchaseAmount = model.purchaseAmount >=10000?[NSString stringWithFormat:@"%ld万",model.purchaseAmount/10000]:[NSString stringWithFormat:@"%ld",model.purchaseAmount];
        NSString * increasingAmount = model.increasingAmount >=10000?[NSString stringWithFormat:@"%ld万",model.increasingAmount/10000]:[NSString stringWithFormat:@"%ld",model.increasingAmount];
        wf.dataArr = [NSMutableArray arrayWithObjects:@{@"title":@"出借规则",@"src":[NSString stringWithFormat:@"起投金额%@元，以%@元的整数倍递增。",purchaseAmount,increasingAmount]},
                      @{@"title":@"退出规则",@"src":@"到期一次性还本付息，还款日为结息日。"},
                      @{@"title":@"项目期限",@"src":@"12+6个月（满12个月可申请提前退出）。"},
                      @{@"title":@"预期年化收益率",@"src":@"对应项目期限为（10.5+5）%，其中满18个月退出为15.5%，满12个月退出为10.5%，此利率为加上平台加息之后的利率按银行五年期固定利率。"},
                      
                      @{@"title":@"计息规则",@"src":@"募集期：自投资次日开始至满标当日计算利息，还款日付息。\n封闭期：自满标次日开始至项目期限最后一日计算利息，还款日付息。\n结息期：为项目到期日顺延10个自然日，如遇节假日顺延，还款日为结息日。\n总收益=募集期收益+预期年化收益+加息收益+结息收益。\n加息收益以项目标识为准，无标识即无加息收益。"},
                      @{@"title":@"加息年利率",@"src":@"活动期间，预期年化收益率基础之上额外增加收益率，实际加息年利率参考页面详情。"},
                      @{@"title":@"募集期利率",@"src":[NSString stringWithFormat:@"项目募集期间利率，按银行五年期固定利率，年利率为%.2f%@。",self.detailsModel.standingInterest,@"%"]},
                      @{@"title":@"结息期利率",@"src":@"结息期利率，为项目封闭期利率。"},
                      @{@"title":@"资金用途",@"src":@"资金投向电子商业汇票系统ECDS中基于真实贸易背景的支付型优质票据。"},
                      @{@"title":@"风控措施",@"src":@"1.线下风控筛选票据资产，线上系统审核承兑企业征信，承兑企业均为上市公司，国企，央企，商业信用优质，保证资金按时到期兑付。\n2.所做票据均为央行开发ECDS系统内电子商业承兑汇票，底层资产真实可查，信息披露及时，公开透明。"}, nil];
        if (self.type ==1) {
            //保理投资
            wf.dataArr = [NSMutableArray arrayWithObjects:@{@"title":@"出借规则",@"src":[NSString stringWithFormat:@"起投金额%@元，以%@元的整数倍递增。",purchaseAmount,increasingAmount]},
                          @{@"title":@"退出规则",@"src":@"到期一次性还本付息，还款日为项目结束后下一个工作日,节假日顺延。"},
                          @{@"title":@"项目期限",@"src":@"12+6个月（满12个月可申请提前退出）。"},
                          @{@"title":@"预期年化收益率",@"src":@"对应项目期限为（10.5+5）%，其中满18个月退出为15.5%，满12个月退出为10.5%，此利率为加上平台加息之后的利率按银行五年期固定利率。"},
                          
                          @{@"title":@"计息规则",@"src":@"募集期：自投资次日开始至满标前一日计算利息，还款日付息。\n封闭期：自满标当日开始至项目期限最后一日计算利息，还款日付息。\n总收益= 募集期收益+ 预期年化收益 + 加息收益。\n加息收益以项目标识为准，无标识即无加息收益。"},
                          @{@"title":@"加息年利率",@"src":@"活动期间，预期年化收益率基础之上额外增加收益率，实际加息年利率参考页面详情。"},
                          @{@"title":@"募集期利率",@"src":[NSString stringWithFormat:@"项目募集期间利率，按银行五年期固定利率，为%.2f%@。",self.detailsModel.standingInterest,@"%"]},
                          @{@"title":@"资金用途",@"src":@"资金投向电子商业汇票系统ECDS中基于真实贸易背景的支付型优质票据。"},
                          @{@"title":@"风控措施",@"src":@"1.线下风控筛选票据资产，线上系统审核承兑企业征信，承兑企业均为上市公司，国企，央企，商业信用优质，保证资金按时到期兑付。\n2.所做票据均为央行开发ECDS系统内电子商业承兑汇票，底层资产真实可查，信息披露及时，公开透明。"}, nil];
        }
        
//      根据类型判断，票据直投，保理还有资产专区，对应类型值是4,1,0
        if (self.type ==0 || self.type ==4) {
            [wf.dataArr removeObjectAtIndex:2];
        }
        wf.data1Arr=@[@{@"title":@"人工专业验票",@"src":@"已通过"},
                    @{@"title":@"持票企业经营资质审核",@"src":@"已通过"},
                    @{@"title":@"开票企业资质审核",@"src":@"已通过"},
                    @{@"title":@"开票企业票据兑付审核",@"src":@"已通过"},
                    ];
        wf.bottomView.numberButton.stepValue = model.increasingAmount;
        NSLog(@"%f-------%f",@(model.reservationAmount).floatValue,@(model.purchaseAmount).floatValue);
        if (@(model.reservationAmount).floatValue < @(model.purchaseAmount).floatValue) {//可预约小于起投金额的情况下
            wf.bottomView.numberButton.currentNumber = model.reservationAmount;

        }else{
            wf.bottomView.numberButton.currentNumber = model.purchaseAmount;

        }
        wf.money = wf.bottomView.numberButton.currentNumber;
//        wf.detailsHeadView.titleLb.text =
        if (model.platformRateYear>0) {
            wf.detailsHeadView.raiseImg.hidden = NO;
            NSString * string =  [NSString stringWithFormat:@"%@+%@",[NSString stringFormatPercentNumberWithFloat:@(model.expectedYield).floatValue],[NSString stringFormatPercentNumberWithFloat:@(model.platformRateYear).floatValue]];
            NSArray *array = [string componentsSeparatedByString:@"+"];
            [wf.detailsHeadView.titleLb setAttributedText:[self changeFontSize:kFont(16) totalStr:string noChangeStr:array[0]]];
        }else{
            wf.detailsHeadView.raiseImg.hidden = YES;
            [wf.detailsHeadView.titleLb setText:[NSString stringFormatPercentNumberWithFloat:@(model.expectedYield).floatValue]];
        }
        wf.detailsHeadView.dayView.titleLabel.text = [NSString stringWithFormat:@"%ld天",(long)model.projectDuration];
        
        if (@(model.purchaseAmount).floatValue > 10000) {
            float purchaseAmount = @(model.purchaseAmount).floatValue /10000;
           wf.detailsHeadView.moneyView.titleLabel.text = [NSString stringWithFormat:@"%0.2f万",purchaseAmount];
        }
        else{
          wf.detailsHeadView.moneyView.titleLabel.text = [NSString stringWithFormat:@"%@",@(model.purchaseAmount)];
        }
        
        if (@(model.proTotalAmount).floatValue > 10000) {
            float purchaseAmount = @(model.proTotalAmount).floatValue /10000;
            wf.detailsHeadView.numView.titleLabel.text = [NSString stringWithFormat:@"%0.2f万",purchaseAmount];
        }
        else{
            wf.detailsHeadView.numView.titleLabel.text = [NSString stringWithFormat:@"%@",@(model.proTotalAmount)];
        }
        if (@(model.reservationAmount).floatValue > 10000) {
            float purchaseAmount = @(model.reservationAmount).floatValue /10000;
            wf.detailsHeadView.num1View.titleLabel.text = [NSString stringWithFormat:@"%0.2f万",purchaseAmount];
        }
        else{
            wf.detailsHeadView.num1View.titleLabel.text = [NSString stringWithFormat:@"%@",@(model.reservationAmount)];
        }
        
        
        [wf.topTableView reloadData];
        [wf.bottom1TableView reloadData];

        [MBProgressHUD hideHUD];
        

    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
        [wf.navigationController popViewControllerAnimated:YES];
    }];
}
/**
 获取记录列表
 */
-(void)getRecordlist{
    __weak typeof(self)wf = self;

    [HttpRequest getRecordListID:self.productID Requestsuccess:^(NSArray * _Nonnull listArr, NSString * _Nonnull message) {
        wf.recordArr = listArr;
        [wf.bottom4TableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
}
//获取票面信息
- (void)getTicketInfomation{
    __weak typeof(self)wf = self;
    [HttpRequest getTicketInfomationID:self.productID Requestsuccess:^(NSArray * _Nonnull listArr, NSString * _Nonnull message) {
        wf.ticketArr = listArr;
        [wf.bottom3TableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];

    }];
}
#pragma mark 以下是懒加载配置
#pragma mark ----- 在 iPhone X 下使用，只需要自己在工程中配置响应的适配frame 即可，封装的控件内部逻辑不变

- (DetailsBottomView *)bottomView{
    __weak typeof(self) weakSelf = self;

    if (!_bottomView) {
           _bottomView = [[DetailsBottomView alloc]initWithType];
        [weakSelf.bottomView.numberButton setEditing:NO];
       
//        weakSelf.bottomView.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
//            NSLog(@"%f",number);
//            NSLog(@"%f-------%f",@(weakSelf.detailsModel.reservationAmount).floatValue,@(weakSelf.detailsModel.purchaseAmount).floatValue);
//
//            weakSelf.money = number;
//            if (number > weakSelf.detailsModel.reservationAmount) {
//                weakSelf.bottomView.numberButton.currentNumber = weakSelf.detailsModel.reservationAmount;
//                weakSelf.money = weakSelf.detailsModel.reservationAmount;
//            }else if (number <= weakSelf.detailsModel.purchaseAmount){
//                weakSelf.money = weakSelf.detailsModel.purchaseAmount;
//                weakSelf.bottomView.numberButton.currentNumber = weakSelf.detailsModel.purchaseAmount;
//
//            }
//
//
//        };
        weakSelf.bottomView.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
            //            reservationAmount 可预约金额
            //            purchaseAmount 起投金额
            //            number         当前金额
            NSLog(@"%f",number);
            NSLog(@"%f-------%f",@(weakSelf.detailsModel.reservationAmount).floatValue,@(weakSelf.detailsModel.purchaseAmount).floatValue);
            
            weakSelf.money = number;
            
            if (number > weakSelf.detailsModel.reservationAmount) {
                weakSelf.bottomView.numberButton.currentNumber = weakSelf.detailsModel.reservationAmount;
                weakSelf.money = weakSelf.detailsModel.reservationAmount;
            }else if (number <= weakSelf.detailsModel.reservationAmount){
                if (weakSelf.detailsModel.reservationAmount < weakSelf.detailsModel.purchaseAmount) {
                    weakSelf.money = weakSelf.detailsModel.reservationAmount;
                    weakSelf.bottomView.numberButton.currentNumber = weakSelf.detailsModel.reservationAmount;
                }else{
                    if (number < weakSelf.detailsModel.purchaseAmount) {
                        weakSelf.money = weakSelf.detailsModel.purchaseAmount;
                        weakSelf.bottomView.numberButton.currentNumber = weakSelf.detailsModel.purchaseAmount;
                    }else{
                        weakSelf.money = number;
                        weakSelf.bottomView.numberButton.currentNumber = number;
                    }
                }
            }
            
        };
        
            [_bottomView setAppointmentBlock:^{
                
                if (![AppUserProfile sharedInstance].isLogon) {
                    
                    TipsViewController *TipsVC=[[TipsViewController alloc]init];
                    TipsVC.titleLbText = @"温馨提示";
                    TipsVC.srcLbText = @"您还没有登录,请登录后预约";
                    [TipsVC setTapCancelBtnblock:^{
                        
                    }];
                    [TipsVC setTapConfirmBtnblock:^{
                        [weakSelf toLoginVC];

                    }];
                    [TipsVC showInVC: weakSelf ];
                    
                    return ;
                }
                [MBProgressHUD showActivityMessageInView:@"正在提交预约..."];
                //立即预约
                [HttpRequest getAppointmentID:weakSelf.productID subscribeAmount:[NSString stringWithFormat:@"%g",weakSelf.money] status:[NSNumber numberWithInteger:weakSelf.type] strategyNumber:weakSelf.detailsModel.strategyNumber  Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
                    [MBProgressHUD hideHUD];
                   
                    SuccessViewController *successVC=[[SuccessViewController alloc]init];
                    successVC.titleLbText = @"预约成功";
                    __weak typeof(successVC) wsuccessVC= successVC;

                    [successVC setOtherblock:^{
                        [wsuccessVC  dismiss];
                        if ([(NSArray*)data.data count]>0) {
                            //跳转到参加活动页面
                            ActivityWebViewVC * vc = [[ActivityWebViewVC alloc]init];
                            ProductDetailsModel * model = [ProductDetailsModel mj_objectWithKeyValues:data.data[0]];
                            vc.url = model.url;
                            vc.investmentId = data.ext;
                            vc.activityId = model.id;
                            [weakSelf.navigationController pushViewController:vc animated:YES];
                            wsuccessVC.srcLbText = @"即将前往活动页";
                        }else{
                            wsuccessVC.srcLbText = @"即将返回";
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        }
                    }];
                    [successVC showInVC:weakSelf];
                } failure:^(NSError * _Nonnull error) {
                    if ([error.localizedDescription isEqualToString:@"未实名认证"]) {
                        [weakSelf gotoAuthentication];
                    }else if ([error.localizedDescription isEqualToString:@"未绑定银行卡"]){
                        [weakSelf gotoTieOnCard];
                        
                    }else{
                        [MBProgressHUD showErrorMessage:error.localizedDescription];
                    }

                }];
 
            }];
          _bottomView.frame = CGRectMake( 0, IphoneHight - 60  - NavHeight -StatusBarHight, Iphonewidth, 60);
    }
    
    return _bottomView;
}
- (FrankDropBounsView *)dropView{
    
    if (!_dropView) {
#if BusinessTag
        CGFloat height = Screen_height - Frank_StatusAndNavBar_Height - Frank_Tabbar_Safe_BottomMargin;

#else
        CGFloat height;
        if (@(_status).intValue == 1) {
         height = Screen_height - CGRectGetHeight(self.bottomView.frame) - Frank_StatusAndNavBar_Height - Frank_Tabbar_Safe_BottomMargin;
        }
        else{
         height = Screen_height - Frank_StatusAndNavBar_Height - Frank_Tabbar_Safe_BottomMargin;
        }
        

#endif
        _dropView = [FrankDropBounsView createFrankDropBounsViewWithFrame:CGRectMake(0, 0, Screen_width, height) withDelegate:self];
        _dropView.needShowAlertView = NO;
        _dropView.alertTitle = @"上拉查看更多内容";
    }
    
    return _dropView;
}

#pragma mark 以上是懒加载配置
#pragma mark ----- 在 iPhone X 下使用，只需要自己在工程中配置响应的适配frame 即可，封装的控件内部逻辑不变

- (void)pullDownToReloadData:(MJRefreshNormalHeader *)table{
    NSLog(@"--- 下拉");
    
    [self.dropView showTopPageViewWithCompleteBlock:^{
        
        [table endRefreshing];
    }];
}
- (void)pullUpToReloadMoreData:(MJRefreshBackNormalFooter *)table{
    NSLog(@"--- 上拉");
    
    [self.dropView showBottomPageViewWithCompleteBlock:^{
        
        [table endRefreshing];
    }];
}
#pragma mark ---------  TripDetailDropDelegate  -------------
/**
 自定义上部展示视图模块 代理方法
 */
- (UIView *)frankDropBounsViewResetTopView{
    
    self.topTableView= [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.topTableView.delegate= self;
    self.topTableView.dataSource= self;
    self.topTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.topTableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.topTableView.tableFooterView = [UIView new];
    _topTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpToReloadMoreData:)];
    
    return _topTableView;
}
#pragma mark ---------  TripDetailDropDelegate  -------------
/**
 自定义切换标题模块 代理方法
 */
- (NSArray *) resetToolbarTitles{
    if (self.type !=1) {
        return @[@"项目介绍",@"项目审核",@"资质信息",@"预约记录"];
    }else{
        return @[@"项目介绍",@"项目审核",@"预约记录"];
    }
}
/**
 自定义底部展示视图模块 代理方法
 */
- (UIView *)resetBottomViewsWithIndex:(NSInteger)index{
    _selectIndex = index;
    NSLog(@"**********%ld",(long)_selectIndex);
  if (index == 1) {
       
        self.bottom1TableView= [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.bottom1TableView.delegate= self;
        self.bottom1TableView.dataSource= self;
        self.bottom1TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.bottom1TableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
        self.bottom1TableView.tableFooterView = [UIView new];
        _bottom1TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownToReloadData:)];
        return _bottom1TableView;
    }else if (index == 2){
        self.bottom2TableView= [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.bottom2TableView.delegate= self;
        self.bottom2TableView.dataSource= self;
        self.bottom2TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.bottom2TableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
        self.bottom2TableView.tableFooterView = [UIView new];
        _bottom2TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownToReloadData:)];
        return _bottom2TableView;
    }else if(index ==3){
        if (self.type !=1) {
            self.bottom3TableView= [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
            self.bottom3TableView.delegate= self;
            self.bottom3TableView.dataSource= self;
            self.bottom3TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            self.bottom3TableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
            self.bottom3TableView.tableFooterView = [UIView new];
            self.bottom3TableView.rowHeight = 200;
            _bottom3TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownToReloadData:)];
            return _bottom3TableView;
        }else{
            self.bottom4TableView= [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
            self.bottom4TableView.delegate= self;
            self.bottom4TableView.dataSource= self;
            self.bottom4TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            self.bottom4TableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
            self.bottom4TableView.tableFooterView = [UIView new];
            _bottom4TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownToReloadData:)];
            return _bottom4TableView;
        }
    }else{
        self.bottom4TableView= [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.bottom4TableView.delegate= self;
        self.bottom4TableView.dataSource= self;
        self.bottom4TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.bottom4TableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
        self.bottom4TableView.tableFooterView = [UIView new];
        _bottom4TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownToReloadData:)];
        return _bottom4TableView;
    }
  
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _bottom4TableView){
        return 2;
    }
    return 1;

}


///////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _topTableView) {
        return 2;
    }else if (tableView == _bottom1TableView){
        return self.dataArr.count+2;
    }else if (tableView == _bottom2TableView){
        return 1;
    }else if (tableView == _bottom3TableView){
        return self.ticketArr.count;
    }else if (tableView == _bottom4TableView){
        if (section == 0) {
            return 1;
        }else{
            return self.recordArr.count ;
        }
    }
    else{
        return 0;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _topTableView) {
        if (indexPath.row == 0) {
        DetailsTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
            
        if (cell == nil) {
            cell= [[DetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.backgroundColor=[UIColor m_bgColor];
        }

        cell.titleLb1.text = @"一次性还本付息";
        NSLog(@"%@",self.detailsModel.increasingAmountStr);
        cell.titleLb2.text = [NSString stringWithFormat:@"%@万及整数倍数递增",self.detailsModel.increasingAmountStr.length == 0 ? @"" : self.detailsModel.increasingAmountStr] ;
            if (Iphonewidth == 320) {
                cell.titleLb2.font = [UIFont s10];
                cell.titleLb1.font = [UIFont s10];

            }
        return cell;
        }else{
            
            DetailsTwoTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell= [[DetailsTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            return cell;
        }
    }else if (tableView == _bottom1TableView){
        if (indexPath.row == self.dataArr.count) {
            UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                cell.textLabel.textColor= kTitleColor;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textLabel.text= [NSString stringWithFormat:@"预览协议"];
            return cell;
        }else if(indexPath.row == self.dataArr.count+1 && self.dataArr.count>0) {
            detailWebviewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"detailWebviewCell"];
            if (cell == nil) {
                cell = [[detailWebviewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"detailWebviewCell"];
                cell.label.text = self.detailsModel.feature;
                [cell.webview loadHTMLString:self.detailsModel.feature baseURL:nil];
                cell.webviewLoadDidFinish = ^{
                    [self.bottom1TableView reloadData];
                };
            }
            return cell;
        }else{
             ProjectTableViewCell*cell= [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (cell == nil) {
                cell= [[ProjectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            }
            if (self.type == 0) {
                //资产专区
                if (indexPath.row ==2) {
                    cell.srcLb.hidden = YES;
                    cell.isShowImage = YES;
                    
                }else{
                    cell.srcLb.hidden = NO;
                    cell.isShowImage = NO;
                }
            }else{
                cell.srcLb.hidden = NO;
                cell.isShowImage = NO;

            }
            cell.titleLb.text = _dataArr[indexPath.row][@"title"];
            cell.srcLb.text = _dataArr[indexPath.row][@"src"];;
            return cell;
        }
   
        }else if (tableView == _bottom2TableView){
            static NSString *CellIdentifier = @"celltable2";
            ExamineTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (cell == nil) {
                cell = [[ExamineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
           
            return cell;
        }else if (tableView == _bottom3TableView){
            TicketInfomationCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell == nil) {
                cell = [[TicketInfomationCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"TicketInfomationCell"];
            }
            [cell.imageV sd_setImageWithURL:kURL(self.ticketArr[indexPath.row]) placeholderImage:placehold];
            return cell;
            
        }else{
            static NSString *CellIdentifier = @"celltable3";
            RecordListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (cell == nil) {
                cell = [[RecordListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            if (indexPath.section == 0) {
                cell.nameLb.text = @"预约人";
                cell.moneyLb.text = @"预约金额";
                cell.timeLb.text = @"预约时间";
                cell.nameLb.font = [UIFont s16];
                cell.nameLb.textColor = kTitleColor;
                cell.timeLb.font = [UIFont s16];
                cell.timeLb.textColor = kTitleColor;
                cell.moneyLb.font = [UIFont s16];
                cell.moneyLb.textColor = kTitleColor;
                cell.backgroundColor = [UIColor m_bgColor];
            }else{
                RecordModel *model   = self.recordArr [indexPath.row];
                cell.nameLb.text = [self phone: model.userName];
                cell.moneyLb.text = @(model.reservationAmount).stringValue;
                cell.timeLb.text = [self parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.addTime] withType:kTimeStampWithSecond];
                if (Iphonewidth == 320) {
                    cell.nameLb.font = [UIFont s12];
                    cell.timeLb.font = [UIFont s12];
                    cell.moneyLb.font = [UIFont s12];
                }
                
                
            }
            return cell;
            
        }
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _bottom1TableView) {
        if (indexPath.row == 8) {
            [self gotoWebURL:_detailsModel.url  title:@"预览协议"];
        }
    }else if (tableView == _bottom3TableView){
        HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
        browser.isFullWidthForLandScape = YES;
        browser.isNeedLandscape = YES;
        browser.currentImageIndex = (int)indexPath.row;
        browser.imageArray = self.ticketArr;
        [browser show];
    }
}

/**
 去实名认证
 */
-(void)gotoAuthentication{
    __weak typeof(self) wf = self;
    SuccessViewController *successVC=[[SuccessViewController alloc]init];
    successVC.titleLbText = @"预约失败";
    successVC.srcLbText = @"未进行实名认证";
    successVC.btnTitle = @"实名认证";
    successVC.btnBgColor = kMainColor;
    successVC.imgName = @"err";
    [successVC setTapBtnblock:^{
        [successVC dismiss];
            CertificationViewController *CertificationVC = [[CertificationViewController alloc]init];
            [wf.navigationController pushViewController:CertificationVC animated:YES];
    }];
    [successVC showInVC:self type:SuccessTypeBtn];
}
/**
 去d绑定银行卡
 */
-(void)gotoTieOnCard{
    __weak typeof(self) wf = self;

    SuccessViewController *successVC=[[SuccessViewController alloc]init];
    successVC.titleLbText = @"预约失败";
    successVC.srcLbText = @"未绑定银行卡";
    successVC.btnTitle = @"去绑卡";
    successVC.btnBgColor = kMainColor;
    successVC.imgName = @"err";
    [successVC setTapBtnblock:^{
        [successVC dismiss];
        BankCardViewController * BankCardVC = [[BankCardViewController alloc]init];
        [wf.navigationController pushViewController:BankCardVC animated:YES];
    }];
    [successVC showInVC:self type:SuccessTypeBtn];
}
- (NSAttributedString*)changeFontSize:(UIFont *)font totalStr:(NSString *)totalStr noChangeStr:(NSString *)str{
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:totalStr];
//    里面的值就好了
    [attriString addAttribute:NSFontAttributeName value:font range:NSMakeRange(str.length,totalStr.length - str.length)];
    return attriString;
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
