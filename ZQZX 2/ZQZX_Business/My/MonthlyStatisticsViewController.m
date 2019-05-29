//
//  MonthlyStatisticsViewController.m
//  ZQZX_Business
//
//  Created by 中企 on 2018/10/22.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MonthlyStatisticsViewController.h"
#import "StatisticsTableViewCell.h"
#import "DVPieChart.h"
#import "DVFoodPieModel.h"
#import "HttpRequest+MyBusiness.h"
#import "StatisticsModel.h"
@interface MonthlyStatisticsViewController ()
@property(nonatomic,strong)NSArray *imgArr;
@property(nonatomic,strong)StatisticsModel *statisticsModel;


@end

@implementation MonthlyStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imgArr = [NSArray arrayWithObjects:@"noContract",@"Contract", nil];
    [self setTableViewEdges:UIEdgeInsetsMake(84, 0, 0, 0)];
    [self.tableView registerClass:[StatisticsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([StatisticsTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.tableView.tableFooterView = [UIView new];
    [self getData];
}
-(void) getData{
    [MBProgressHUD showActivityMessageInView:nil];

    [HttpRequest getMonethStatisticsRequestsuccess:^(StatisticsModel * _Nonnull model, NSString * _Nonnull message) {
        [MBProgressHUD hideHUD];
        self.statisticsModel = model;
        [self setHeadView];
        [self.tableView reloadData];

    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
}
-(void)setHeadView{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, Iphonewidth, 331)];
    
    
    DVPieChart *chart = [[DVPieChart alloc] initWithFrame:CGRectMake(0, 30, Iphonewidth, 320)];
    [headView addSubview:chart];

    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(10, 330, Iphonewidth-20, 1)];
    line.backgroundColor = [UIColor m_lineColor];
    [headView addSubview:line];
    
    UIImageView  *sanjiaoImg = [[UIImageView alloc]initWithFrame:CGRectMake(Iphonewidth/2-11, 320, 22, 11)];
    sanjiaoImg.image = [UIImage imageNamed:@"sanjiao"];
    [headView addSubview:sanjiaoImg];

    
    
    self.tableView.tableHeaderView = headView;
    
    float d =@(_statisticsModel.dqy.num).intValue + @(_statisticsModel.yqy.num).intValue;
    CGFloat f = _statisticsModel.dqy.num / d ;
    if (_statisticsModel.dqy.num ==0 &&_statisticsModel.yqy.num==0) {
        f = 0.5f;
    }else if(_statisticsModel.dqy.num==0){
        f = 0.1f;
    }else if (_statisticsModel.yqy.num ==0){
        f = 0.9f;
    }
    DVFoodPieModel *model1 = [[DVFoodPieModel alloc] init];
    model1.rate = f;
    model1.name = [NSString stringWithFormat:@"待签约%@单",@(_statisticsModel.dqy.num).stringValue];
    model1.value = 423651.23;
    model1.orderNum = _statisticsModel.dqy.actualAmount;
    model1.cakeColor = [UIColor colorWithRed:252.0/255.0 green:150.0/255.0 blue:50.0/255.0 alpha:1];
    
    DVFoodPieModel *model2 = [[DVFoodPieModel alloc] init];
    model2.rate = 1 - f;
    model2.name = [NSString stringWithFormat:@"累计投资%@单",@(_statisticsModel.yqy.num).stringValue];
    model2.value = 423651.23;
    model2.orderNum = _statisticsModel.yqy.actualAmount;
    model1.cakeColor = [UIColor colorWithRed:73.0/255.0 green:136.0/255.0 blue:242.0/255.0 alpha:1];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    NSArray *dataArray = @[model1, model2];
    chart.dataArray = dataArray;
    chart.title = DateTime;
    [chart draw];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StatisticsTableViewCell class]) forIndexPath:indexPath];
    if (Iphonewidth == 320) {
        cell.srcNumLb.font = [UIFont s12];
        cell.srcMoneyLB.font = [UIFont s12];
    }
    if (indexPath.row == 0) {
        cell.srcNumLb.text = @"本月待签约订单";
        cell.numLb.text = [NSString stringWithFormat:@"%@单",@(_statisticsModel.dqy.num).stringValue];
        cell.srcMoneyLB.text = @"本月待签约金额";
        cell.moneyLB.text =  [NSString stringWithFormat:@"%@元",[self moneyStr:_statisticsModel.dqy.actualAmount]];
     
    }else{
        cell.srcNumLb.text = @"本月累计投资订单";
        cell.numLb.text = [NSString stringWithFormat:@"%@单",@(_statisticsModel.yqy.num).stringValue];
        cell.srcMoneyLB.text = @"本月累计投资金额";
        cell.moneyLB.text = [NSString stringWithFormat:@"%@元",[self moneyStr:_statisticsModel.yqy.actualAmount]];
    }
    cell.imgView.image = [UIImage imageNamed:_imgArr[indexPath.row]];
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
