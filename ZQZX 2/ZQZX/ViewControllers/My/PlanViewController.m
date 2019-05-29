//
//  PlanViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "PlanViewController.h"
#import "PlanTableViewCell.h"
#import "HttpRequest+my.h"
#import "ReimbursementModel.h"
#import "ReimbursementplanDetailsVC.h"

@interface PlanViewController ()
@property(nonatomic,strong)NSMutableArray *dataListArr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSString *productType;//待回款：0；已回款：1
@property(nonatomic,strong)NSNumber *status;//待回款：0；已回款：1//待回款statusTwo=2；已回款statusTwo=3

@end

@implementation PlanViewController
- (instancetype)initType:(NSString *)type status:(NSNumber*)status{
    self = [super init];
    if (self) {
        _productType = type;
        _status = status;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) wf = self;

    [self setTableViewEdges:UIEdgeInsetsMake(84, 0, 0, 0)];
    [self.tableView registerClass:[PlanTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PlanTableViewCell class])];
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
    [self.tableView refresh];
}
-(void)requestList
{
    __weak typeof(self) wf = self;
    [HttpRequest returnMoneySchemesStatus:_page status:_productType statusTwo:self.status Requestsuccess:^(ReimbursementModel * _Nonnull model, NSString * _Nonnull message) {
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PlanTableViewCell class]) forIndexPath:indexPath];
    ReimbursementListModel *model = self.dataListArr[indexPath.row];
    cell.titleLb.text = model.borrowName;
    cell.typeView.srcLabel.text = [self type:@(model.type).stringValue];
    cell.moneyView.srcLabel.text = [self appointmentMoneyStr:model.priAndInt];
    cell.timeView.srcLabel.text = [self parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.repTime] withType:kTimeStampDateOnlyHorizonLine];
    cell.periodlab.text = [NSString stringWithFormat:@"第%ld期",model.period];
    cell.timeView.titleLabel.text = [_productType intValue] == 0 ? @"回款日期" : @"回款日期";
    return cell;
}

//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ReimbursementListModel *model = self.dataListArr[indexPath.row];
    ReimbursementplanDetailsVC *detailsVC  = [[ReimbursementplanDetailsVC alloc]init];
    detailsVC.detailsID = [NSString stringWithFormat:@"%ld",(long)model.id];
    detailsVC.type = _productType;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
/**
 产品类型
 
 @param str str description
 @return return value description
 */
-(NSString *)type:(NSString *)str{
    if ([str isEqualToString:@"0"]) {
        return @"票据";
    }else if ([str isEqualToString:@"1"]){
        return @"保理";
    }else if ([str isEqualToString:@"2"]){
        return @"房产";
    }else if ([str isEqualToString:@"3"]){
        return @"股权";
    }else if ([str isEqualToString:@"4"]){
        return @"票据直投";
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
