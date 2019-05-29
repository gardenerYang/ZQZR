//
//  MyBusinessOtherOrderVC.m
//  ZQZX_Business
//
//  Created by 中企 on 2018/11/2.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyBusinessOtherOrderVC.h"
#import "HttpRequest+MyBusiness.h"
#import "BusinessOrderModel.h"
#import "MyOrderTableViewCell.h"
#import "MyBusinessOrderTwodetailsVC.h"
#import "MyBusinessOrderdetailsVC.h"
@interface MyBusinessOtherOrderVC ()
@property(nonatomic,strong)NSMutableArray *dataListArr;
@property(nonatomic,assign)int page;
@end

@implementation MyBusinessOtherOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) wf = self;
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MyOrderTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.tableView.tableFooterView = [UIView new];
    [self.tableView addMJ_Header:^{
        wf.page=1;
        wf.dataListArr=[[NSMutableArray alloc]init];
        [wf requestList];
    }];
    [self.tableView addMJ_Footer:^{
        [wf requestList];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView refresh];
}
-(void)requestList
{
    __weak typeof(self) wf = self;
    
    [HttpRequest myBusinessOrderPageNum:_page dataStatus:@"" type:@"" status:_status Requestsuccess:^(BusinessOrderModel * _Nonnull model, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        
        if (self.page * 10 >= model.total) {
            [wf.tableView noMoreData];
        }else{
            wf.page ++;
            [wf.tableView resetMoreData];
        }
        [self.dataListArr addObjectsFromArray:model.cList];
        if (self.dataListArr.count == 0) {
            [wf addNodataView:@"noorder" : @"暂无订单"  reload:^{
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyOrderTableViewCell class]) forIndexPath:indexPath];
    BusinessOrderListModel *model = self.dataListArr[indexPath.row];
    
    cell.orderNumLb.text = [NSString stringWithFormat:@"订单编号 %@",model.investmentNo] ;
    cell.timeLb.text = [self parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.addTime] withType:kTimeStampDateOnlyHorizonLine];
    cell.titleLb.text = model.name;
    cell.tagLb.text = [self status:@(model.status).stringValue];
    cell.moneyLb.text = [self appointmentMoneyStr:model.subscribeAmount] ;
    
    cell.numLb.text = [self annualRate:model.expectedYield];
    return cell;
}

//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BusinessOrderListModel *model = self.dataListArr[indexPath.row];
#if BusinessTag
    if (model.status == 0 || model.status == 4) {
        MyBusinessOrderdetailsVC *OrderdetailsVC = [[MyBusinessOrderdetailsVC alloc]init];
        OrderdetailsVC.ordID = @(model.id).stringValue;
        [self.navigationController pushViewController:OrderdetailsVC animated:YES];
    }else{
        MyBusinessOrderTwodetailsVC *OrderdetailsVC = [[MyBusinessOrderTwodetailsVC alloc]init];
        OrderdetailsVC.ordID = @(model.id).stringValue;
        [self.navigationController pushViewController:OrderdetailsVC animated:YES];
    }
#else
    if (model.status == 0 || model.status == 4) {
        MyBusinessOrderdetailsVC *OrderdetailsVC = [[MyBusinessOrderdetailsVC alloc]init];
        OrderdetailsVC.ordID = @(model.id).stringValue;
        [self.navigationController pushViewController:OrderdetailsVC animated:YES];
    }else{
        MyBusinessOrderTwodetailsVC *OrderdetailsVC = [[MyBusinessOrderTwodetailsVC alloc]init];
        OrderdetailsVC.ordID = @(model.id).stringValue;
        [self.navigationController pushViewController:OrderdetailsVC animated:YES];
    }
    
#endif

}
/**
 时间范围参数
 
 @param str str description
 @return return value description
 */
-(NSString *)dataStatus:(NSString *)str{
    
    if ([str isEqualToString:@"全部"]) {
        return @"0";
    }else if ([str isEqualToString:@"3个月以下"]){
        return @"1";
    }else if ([str isEqualToString:@"3-6个月"]){
        return @"2";
    }else if ([str isEqualToString:@"6-12个月"]){
        return @"3";
    }
    else{
        return @"4";
    }
}

/**
 投资状态
 
 @param str str description
 @return return value description
 */
-(NSString *)status:(NSString *)str{
    //@[@"待受理",@"待签约",@"已签约",@"签约作废",@"签约不成功",@"已取消",@"已退款",@"待赎回",@"已赎回",@"待还款",@"已还款"];
    if ([str isEqualToString:@"待受理"]) {
        return @"0";
    }else if ([str isEqualToString:@"待签约"]){
        return @"1";
    }else if ([str isEqualToString:@"已签约"]){
        return @"2";
    }else if ([str isEqualToString:@"签约作废"]){
        return @"3";
    }else if ([str isEqualToString:@"签约不成功"]){
        return @"4";
    }else if ([str isEqualToString:@"已取消"]){
        return @"5";
    }else if ([str isEqualToString:@"已退款"]){
        return @"6";
    }else if ([str isEqualToString:@"待赎回"]){
        return @"7";
    }else if ([str isEqualToString:@"已赎回"]){
        return @"8";
    }else if ([str isEqualToString:@"待还款"]){
        return @"9";
    }else if ([str isEqualToString:@"已还款"]){
        return @"10";
    }else if ([str isEqualToString:@"待签约"]){
        return @"11";
    }
    else{
        return @"";
    }
    
}


/**
 产品类型
 
 @param str str description
 @return return value description
 */
-(NSString *)type:(NSString *)str{
    if ([str isEqualToString:@"票据"]) {
        return @"0";
    }else if ([str isEqualToString:@"保理"]){
        return @"1";
    }else if ([str isEqualToString:@"房产"]){
        return @"2";
    }else if ([str isEqualToString:@"股权"]){
        return @"3";
    }else if ([str isEqualToString:@"票据直投"]){
        return @"4";
    }
    else{
        return @"";
    }
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
