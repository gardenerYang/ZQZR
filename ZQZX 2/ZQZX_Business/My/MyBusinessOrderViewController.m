//
//  MyBusinessOrderViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/11/2.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyBusinessOrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "OrderdetailsViewController.h"
#import "QZConditionFilterView.h"
#import "UIView+Extension.h"

#import "HttpRequest+MyBusiness.h"
#import "BusinessOrderModel.h"
#import "MyBusinessOrderdetailsVC.h"//可编辑
#import "MyBusinessOrderTwodetailsVC.h"//不可编辑

@interface MyBusinessOrderViewController ()
@property (nonatomic, strong) QZConditionFilterView          *conditionFilterView;

@property (nonatomic, strong) NSArray          *selectedDataSource1Ary;
@property (nonatomic, strong) NSArray          *selectedDataSource2Ary;
@property (nonatomic, strong) NSArray          *selectedDataSource3Ary;

@property(nonatomic,strong)NSMutableArray *dataListArr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSString *dataStatusStr;//时间范围参数
@property(nonatomic,strong)NSString *typeStr;//产品类型
@property(nonatomic,strong)NSString *statusStr;//投资状态
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation MyBusinessOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle: @"我的订单"];
    __weak typeof(self) wf = self;
    wf.dataStatusStr = @"0";
    wf.typeStr = @"0";
    wf.statusStr = @"";
    _dataArr = @[@"待受理",@"待签约",@"已签约",@"签约作废",@"签约不成功",@"已取消",@"已退款",@"待赎回",@"已赎回",@"待还款",@"已还款",@"待签约"];
    _conditionFilterView = [QZConditionFilterView conditionFilterViewWithFilterBlock:^(BOOL isFilter, NSArray *dataSource1Ary, NSArray *dataSource2Ary, NSArray *dataSource3Ary) {
        // 1.isFilter = YES 代表是用户下拉选择了某一项
        // 2.dataSource1Ary 选择后第一组选择的数据  2 3一次类推
        // 3.如果你的项目没有清空筛选条件的功能，可以无视else 我们的app有清空之前的条件，重置，所以才有else的逻辑
        if (isFilter) {
            //网络加载请求 存储请求参数
            wf.selectedDataSource1Ary = dataSource1Ary.count == 0 ? @[@"全部"] : dataSource1Ary ;
            wf.selectedDataSource2Ary = dataSource2Ary.count == 0 ? @[@"全部"] : dataSource2Ary ;
            wf.selectedDataSource3Ary = dataSource3Ary.count == 0 ? @[@"全部"] : dataSource3Ary ;
            wf.dataStatusStr = [wf dataStatus:dataSource1Ary[0]];
            wf.statusStr = [wf status:dataSource2Ary[0]];
            wf.typeStr = [wf type:dataSource3Ary[0]];
            [wf.tableView refresh];
        }else{
            // 不是筛选，全部赋初值（在这个工程其实是没用的，因为tableView是选中后必选的，即一旦选中就没有空的情况，但是如果可以清空筛选条件的时候就有必要 *重新* reset data）
            //            wf.selectedDataSource1Ary = @[@"默认条件"];
            //            wf.selectedDataSource2Ary = @[@"默认条件"];
            //            wf.selectedDataSource3Ary = @[@"默认条件"];
            
        }
        
        // 开始网络请求
        //        [self startRequest];
    }];
    
    _conditionFilterView.y += 0;
    // 设置初次加载显示的默认数据 即初次加载还没有选择操作之前要显示的标题数据
    _selectedDataSource1Ary = @[@"全部"];
    _selectedDataSource2Ary = @[@"全部"];
    _selectedDataSource3Ary = @[@"全部"];
    
    // 传入数据源，对应三个tableView顺序
    _conditionFilterView.dataAry1 = @[@"全部",@"3个月以下",@"3-6个月",@"6-12个月",@"12个月以上"];
    _conditionFilterView.dataAry2 = @[@"待受理",@"待签约",@"已签约",@"签约作废",@"签约不成功",@"已取消",@"已退款",@"待赎回",@"已赎回",@"待还款",@"已还款"];
    _conditionFilterView.dataAry3 = @[@"票据",@"保理",@"房产",@"股权",@"票据直投"];
    
    // 初次设置默认显示数据(标题)，内部会调用block 进行第一次数据加载
    [_conditionFilterView bindChoseArrayDataSource1:_selectedDataSource1Ary DataSource2:_selectedDataSource2Ary DataSource3:_selectedDataSource3Ary];
    
    [self.view addSubview:_conditionFilterView];
    
    
    [self setTableViewEdges:UIEdgeInsetsMake(60, 0, 0, 0)];
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
    
    [HttpRequest myBusinessOrderPageNum:_page dataStatus:_dataStatusStr type:_typeStr status:_statusStr Requestsuccess:^(BusinessOrderModel * _Nonnull model, NSString * _Nonnull message) {
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
    NSInteger rows = model.status;
    cell.tagLb.text = _dataArr[rows];
  
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
    if (self.dataListArr.count ==0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BusinessOrderListModel *model = self.dataListArr[indexPath.row];
    if (model.status == 0 || model.status == 4) {
        MyBusinessOrderdetailsVC *OrderdetailsVC = [[MyBusinessOrderdetailsVC alloc]init];
        OrderdetailsVC.ordID = @(model.id).stringValue;
        [self.navigationController pushViewController:OrderdetailsVC animated:YES];
    }else{
        MyBusinessOrderTwodetailsVC *OrderdetailsVC = [[MyBusinessOrderTwodetailsVC alloc]init];
        OrderdetailsVC.ordID = @(model.id).stringValue;
        [self.navigationController pushViewController:OrderdetailsVC animated:YES];
    }

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
    }else if ([str isEqualToString:@"12个月以上"]){
        return @"4";
    }
    else{
        return @"";
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

