//
//  ProjectIntroductionVC.m
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ProjectIntroductionVC.h"
#import "ProjectTableViewCell.h"
@interface ProjectIntroductionVC ()
@property(nonatomic,strong)NSArray *dataArr;

@end

@implementation ProjectIntroductionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _dataArr = [NSArray arrayWithObjects:@{[@"title" : @"出借规则",@"src" : @"出借规则"]}, nil]
    _dataArr=@[@{@"title":@"出借规则",@"src":@"起投金额5万，以1万元的整数倍递增。"},
              @{@"title":@"退出规则",@"src":@"到期一次性还本付息,还款日为项目结束后下一个工作日,节假日顺延。"},
              @{@"title":@"预期收益",@"src":@"单个出借中借款标应计利息=出借本金*年利率*(累计计息天数/365)。"},
              @{@"title":@"计息规则",@"src":@"即投即息，即T+1,从投资次日开始计算利息；到期付息。"},
              @{@"title":@"资金用途",@"src":@"资金投向电子商业汇票系统ECDS中基于真实贸易背景的支付型优质票据。"},
              @{@"title":@"风控措施",@"src":@"1.线下风控筛选票据资产，线上系统审核承兑企业征信，承兑企业均为上市公司，国企，央企，商业信用优质，保证资金按时到期兑付。\n2.所做票据均为央行开发ECDS系统内电子商业承兑汇票，底层资产真实可查，信息披露及时，公开透明。"},];
    
    [self setTableViewEdges:UIEdgeInsetsMake(0 , 0, 0, 0)];
    
    [self.tableView registerClass:[ProjectTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ProjectTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.tableView.tableFooterView = [UIView new];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 6) {
        UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.text= [NSString stringWithFormat:@"预览协议"];
            cell.textLabel.textColor= [UIColor blackColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
        }
        return cell;
    }
    else{
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProjectTableViewCell class]) forIndexPath:indexPath];
    cell.titleLb.text = _dataArr[indexPath.row][@"title"];
    cell.srcLb.text = _dataArr[indexPath.row][@"src"];;
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
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
