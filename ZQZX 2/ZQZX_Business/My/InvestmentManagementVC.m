//
//  InvestmentManagementVC.m
//  ZQZX
//
//  Created by 中企 on 2018/10/23.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "InvestmentManagementVC.h"
#import "InvestmentManagementCell.h"
#import "HttpRequest+MyBusiness.h"
@interface InvestmentManagementVC ()
@property(nonatomic,strong)NSMutableArray *dataListArr;
@property(nonatomic,assign)int page;
@end

@implementation InvestmentManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) wf = self;

    [self setCustomerTitle:@"用户投资管理"];
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[InvestmentManagementCell class] forCellReuseIdentifier:NSStringFromClass([InvestmentManagementCell class])];
    [self.tableView addMJ_Header:^{
        wf.page=1;
        wf.dataListArr=[[NSMutableArray alloc]init];
        [wf requestList];
    }];
    [self.tableView addMJ_Footer:^{
        [wf requestList];
    }];
    [self.tableView refresh];
}
-(void)requestList
{
    __weak typeof(self) wf = self;
    
    [HttpRequest getBusinessInvestmentPageNum:_page Requestsuccess:^(BusinessInvestmentModel * _Nonnull model, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        if (self.page * 10 >= model.total) {
            [wf.tableView noMoreData];
        }else{
            wf.page ++;
            [wf.tableView resetMoreData];
        }
        [self.dataListArr addObjectsFromArray:model.cList];
        if (self.dataListArr.count == 0) {
            [wf addNodataView:@"norecord" : @"暂无记录"  reload:^{
                [wf requestList];
            }];
        }else{
            [wf hideNoDataView];
        }
        [wf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [wf.tableView stopReload];
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
  
}
//getBusinessInvestmentPageNum
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InvestmentManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InvestmentManagementCell class]) forIndexPath:indexPath];
    BusinessInvestmentListModel *model = self.dataListArr[indexPath.row];
    cell.nameLb.text = model.realName;
    cell.money1Lb.text = [NSString stringWithFormat:@"待签约金额:%@",@(model.dqy).stringValue] ;
    cell.money2Lb.text = [NSString stringWithFormat:@"累计投资金额:%@",@(model.yqy).stringValue] ;
    cell.money3Lb.text =[NSString stringWithFormat:@"预期总收益:%@",@(model.incomeAmount).stringValue];
    [cell.imgView sd_setImageWithString:model.headPortraitUrl];
    
    return cell;
    
}

//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
