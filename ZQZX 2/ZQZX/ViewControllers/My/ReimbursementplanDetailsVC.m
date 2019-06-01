//
//  ReimbursementplanDetailsVC.m
//  ZQZX
//
//  Created by 中企 on 2018/11/5.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ReimbursementplanDetailsVC.h"
#import "MyTableViewCell.h"
#import "HttpRequest+my.h"
#import "PlanDetailsModel.h"
#import "OrderEarningsDetails.h"
#import "ActivityAlertView.h"
#import "SuccessViewController.h"
@interface ReimbursementplanDetailsVC ()
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)PlanDetailsModel *model;
@property (nonatomic,assign) NSInteger iteration;//0不展示 iteration：1展示
@property (nonatomic,strong) ActivityAlertView * alertView;
@property (nonatomic,strong) UIView * shadeView;
@property (nonatomic,strong) UIView * footerView;
@property (nonatomic,strong) UIButton * funcBtn;

@end

@implementation ReimbursementplanDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([_type intValue] == 0) {
        _titleArr = [NSArray arrayWithObjects:@"产品名称",@"产品期数",@"状态",@"年化收益率",@"投资总额",@"投资日期",@"起息日期",@"还款时间",@"待收收益",@"待回总额", nil];
    }
    else
    {
    _titleArr = [NSArray arrayWithObjects:@"产品名称",@"产品期数",@"状态",@"年化收益率",@"投资总额",@"投资日期",@"起息日期",@"还款时间",@"已收益",@"回款总额", nil];
    }
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MyTableViewCell class])];
    __weak typeof(self) wf = self;

    [self.tableView addMJ_Header:^{
        [wf requestList];
    }];
    [self.tableView refresh];
}
-(void)requestList
{
    __weak typeof(self) wf = self;
    
    [HttpRequest returnMoneySchemesdetailsID:wf.detailsID Requestsuccess:^(PlanDetailsModel * _Nonnull model, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        wf.model = model;
        [wf setCustomerTitle:model.borrowName];
        wf.iteration = model.iteration;
        [wf.tableView reloadData];

    } failure:^(NSError * _Nonnull error) {
        [wf.tableView stopReload];
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
    
}
//参数：investmentId（计划详情id）
//operation：赎回传参1，续期传参2
//userId:用户id

- (void)requestmyInsertApply{
    [HttpRequest post:my_insertApplyFor param:@{@"investmentId":[NSNumber numberWithInteger:self.model.id],@"operation":self.model.flag==0?@1:@2,@"userId":[AppUserProfile sharedInstance].userId} success:^(HttpResponse *data, NSString *message) {
        SuccessViewController *successVC=[[SuccessViewController alloc]init];
        if (self.model.iteration == 1) {
            successVC.titleLbText = self.model.flag==0?@"赎回成功":@"续投成功";
            if (self.model.flag == 0) {//老产品
                successVC.titleLbText = @"续  投";
                successVC.srcLbText = @"续投成功";
            }else{
                successVC.titleLbText = @"赎  回";
                successVC.srcLbText = @"赎回成功";
            }
        }
        __weak typeof(successVC) wSuccessVC = successVC;
        [successVC setOtherblock:^{
            [wSuccessVC dismiss];
        }];
        [successVC showInVC:self];
        [self requestList];
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
}
//显示弹出框
- (void)showAlertView{
    self.shadeView.alpha = 0.5f;
    self.alertView.alpha = 1;
    __weak typeof(self) weakSelf = self;
    [_shadeView addTapGestureBlock:^(UIView *view) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.shadeView.alpha = 0;
            weakSelf.alertView.alpha = 0;
        }];
    }];
    [self.alertView.funcBtn addTapGestureBlock:^(UIView *view) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.shadeView.alpha = 0;
            weakSelf.alertView.alpha = 0;
        }];
        [weakSelf requestmyInsertApply];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
            return self.titleArr.count;
    }else{
        if (self.model.iteration) {
            return 2;
        }
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    MyTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier type:cellTypeDefault];
    }    
    if (indexPath.section == 1) {
        if (indexPath.row ==0) {
            cell.titleLb.text = @"查看协议";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            UITableViewCell * cell1 = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell1) {
                cell1 = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell1"];
            }
            cell1.backgroundColor = kTabBGColor;
            UIButton * button = [[UIButton alloc]init];
            [cell1 addSubview:button];
            button.backgroundColor = [UIColor withHexStr:@"ff6824"];
            [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [button.titleLabel setFont:kFont(18)];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell1).offset(33);
                make.bottom.equalTo(cell1).offset(-33);
                make.centerX.equalTo(cell1);
                make.size.mas_equalTo(CGSizeMake(kWidth-40, 44));
                
            }];
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 22.f;
            self.funcBtn = button;
            [button addAction:^(UIButton * _Nonnull sender) {
                //显示弹窗 是否续投/赎回
                [self showAlertView];
            }];
            if (self.model.flag ==0) {
                [ self.funcBtn  setTitle:@"续投" forState:(UIControlStateNormal)];
            }else{
                [ self.funcBtn  setTitle:@"赎回" forState:(UIControlStateNormal)];
            }
            return cell1;
        }
    }else{
        cell.titleLb.text = _titleArr[indexPath.row];
        cell.titleLb.textColor = [UIColor m_textDeepGrayColor];
        if (indexPath.row == 0) {
            cell.srcLb.text = _model.borrowName;
        }else if (indexPath.row == 1){
            cell.srcLb.text = [NSString stringWithFormat:@"第%ld期",(long)_model.period];
        }
        else if (indexPath.row == 2){
            cell.srcLb.text = [self status: _model.status];
            cell.srcLb.textColor = kMainColor;

        }else if (indexPath.row == 3){
            cell.srcLb.text = [self annualRate:_model.rateYear];
        }else if (indexPath.row == 4){
            cell.srcLb.text = [NSString stringWithFormat:@"%@",[self moneyStr:_model.actualAmount]];
        }else if (indexPath.row == 5){
            cell.srcLb.text = _model.payTime;
        }else if (indexPath.row == 6){
            cell.srcLb.text = [self parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)_model.carryInterestTime] withType:kTimeStampDateOnlyHorizonLine];
        }else if (indexPath.row == 7){
            cell.srcLb.text = [self parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)_model.repaymentTime] withType:kTimeStampDateOnlyHorizonLine];
        }else if (indexPath.row == 8){
            cell.srcLb.text = [NSString stringWithFormat:@"%.2f",_model.interest];
            cell.arrowImg.hidden = NO;
        }else{
            cell.srcLb.text = [NSString stringWithFormat:@"%.2f",_model.repaymentAmount];
        }

        [cell updateLB];
        
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self gotoWebURL:_model.url htmlText:@"" title:@""];
    }else{
        if (indexPath.row ==8) {
            OrderEarningsDetails * vc = [[OrderEarningsDetails alloc] init];
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }

}

-(NSString *)status:(NSInteger)status
{
    if (status == 0) {
        return @"待还款";
    }else if (status == 1){
        return @"已还款";
    }else{
        return @"未复审通过 ";
    }
}
- (UIView *)shadeView{
    if (_shadeView ==nil) {
        _shadeView = [[UIView alloc]initWithFrame:kWindow.bounds];
        [kWindow addSubview:_shadeView];
        _shadeView.backgroundColor = kTitleColor;
        _shadeView.alpha = 0;
    }
    return _shadeView;
}
- (ActivityAlertView *)alertView{
    if (_alertView ==nil) {
        _alertView = [[[NSBundle mainBundle]loadNibNamed:@"ActivityAlertView" owner:self options:0] lastObject];
        [kWindow addSubview:_alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(kWindow);
            make.centerY.equalTo(kWindow).offset(-50);
            make.size.mas_equalTo(CGSizeMake(250, 200));
        }];
        _alertView.alpha = 0;
    }
    _alertView.model = self.model;
    return _alertView;
}
@end
