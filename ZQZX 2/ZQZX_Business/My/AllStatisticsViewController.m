//
//  AllStatisticsViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/23.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "AllStatisticsViewController.h"
#import "StatisticsTableViewCell.h"
#import "Charts-Swift.h"
#import "HttpRequest+MyBusiness.h"
#import "AllBusinessInvestmentModel.h"
@interface AllStatisticsViewController ()<ChartViewDelegate>
@property(nonatomic,strong)LineChartView *lineChartView;
@property(nonatomic,strong)NSArray *imgArr;
@property(nonatomic,strong)AllBusinessInvestmentModel *model;

@end

@implementation AllStatisticsViewController
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
-(void)getData{
    [HttpRequest getAllMonethStatisticsRequestsuccess:^(AllBusinessInvestmentModel * _Nonnull model, NSString * _Nonnull message) {
        self.model = model;
        [self.tableView reloadData];
        [self setHeadView];

    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
}
-(void)setHeadView{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, Iphonewidth, IphoneHight/2 +30)];
    
    _lineChartView = [[LineChartView alloc]initWithFrame:CGRectMake(20, 10, Iphonewidth-20, IphoneHight/2)];
    _lineChartView.delegate =self;
    _lineChartView.chartDescription.enabled = NO;
    _lineChartView.dragEnabled = YES;
    [_lineChartView setScaleEnabled:YES];
    
    _lineChartView.pinchZoomEnabled = YES;
    _lineChartView.doubleTapToZoomEnabled = NO;
    _lineChartView.doubleTapToZoomEnabled = false;//取消双击缩放
    _lineChartView.xAxis.drawGridLinesEnabled = NO;//不绘制y网格线
    _lineChartView.xAxis.drawAxisLineEnabled = NO;//不绘制x网格线
    
    _lineChartView.xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    _lineChartView.noDataText = @"暂无数据";
    _lineChartView.leftAxis.labelTextColor = [UIColor m_red];//左边y轴颜色
    _lineChartView.rightAxis.labelTextColor = [UIColor m_blue];//右边y轴颜色
    _lineChartView.rightAxis.enabled = NO;
    
     ChartYAxis *leftAxis =_lineChartView.leftAxis;
    [leftAxis removeAllLimitLines];
    leftAxis.axisMaximum = 50;
    leftAxis.axisMinimum = 0;
    //        leftAxis.gridLineDashLengths = [5, 5]
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    
    
//    ChartYAxis *rightAxis =_lineChartView.rightAxis;
//    rightAxis.labelTextColor = [UIColor greenColor];
//    rightAxis.axisMaximum = 100;
//    rightAxis.axisMinimum = 0;
//    rightAxis.granularityEnabled = NO;
////    _lineChartView.legend.form = .line
    [_lineChartView animateWithXAxisDuration:2.5];
    [self setDataCount:@(self.model.dqy.count).intValue range:50];
    
    
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(10,IphoneHight/2+29, Iphonewidth-20, 1)];
    line.backgroundColor = [UIColor m_lineColor];
    [headView addSubview:line];

    UIImageView  *sanjiaoImg = [[UIImageView alloc]initWithFrame:CGRectMake(Iphonewidth/2-11, IphoneHight/2 +19, 22, 11)];
    sanjiaoImg.image = [UIImage imageNamed:@"sanjiao"];
    [headView addSubview:sanjiaoImg];
    
    
    [headView addSubview:_lineChartView];
    self.tableView.tableHeaderView = headView;
    
    
    
    
}
- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    NSMutableArray *values1 = [[NSMutableArray alloc] init];

    for (int i = 0; i < self.model.yqy.count; i++)
    {
        YqyItem *model = self.model.yqy[i];
        [values addObject:[[ChartDataEntry alloc] initWithX:model.month y:model.num icon: [UIImage imageNamed:@"icon"]]];
    }
    for (int i = 0; i < count; i++)
    {
        DqyItem *model = self.model.dqy[i];

        [values1 addObject:[[ChartDataEntry alloc] initWithX:model.month y:model.num icon: [UIImage imageNamed:@"icon"]]];
    }
    LineChartDataSet *set1 = [[LineChartDataSet alloc]initWithValues:values label:@"待签约"];
    [set1 setCircleColor:[UIColor withHexStr:@"#7ddaff"]];
    set1.colors =[NSArray arrayWithObjects:[UIColor withHexStr:@"#7ddaff"], nil];
    set1.mode = LineChartModeHorizontalBezier;
    set1.axisDependency = AxisDependencyLeft;
    
    //设置区域颜色
    NSArray *gradientColors = @[
                                (id)[UIColor withHexStr:@"#f4fcff"].CGColor,
                                (id)[UIColor withHexStr:@"#7ddaff"].CGColor
                                ];
    CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
    
    set1.fillAlpha = 1.f;
    set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
    set1.drawFilledEnabled = YES;
    CGGradientRelease(gradient);
    
//第一根第二条线
    
    LineChartDataSet *set2 = [[LineChartDataSet alloc]initWithValues:values1 label:@"累计投资"];
    [set2 setCircleColor:[UIColor m_Lightred]];
    set2.colors =[NSArray arrayWithObjects:[UIColor m_Lightred], nil];
    set2.mode = LineChartModeHorizontalBezier;
    set2.axisDependency = AxisDependencyLeft;
    
    
    //第二根线设置区域颜色
//    NSArray *gradientColors1 = @[
//                                (id)[UIColor withHexStr:@"#fef5f0"].CGColor,
//                                (id)[UIColor m_Lightred].CGColor
//                                ];
//    CGGradientRef gradient1 = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors1, nil);
//
//    set2.fillAlpha = 1.f;
//    set2.fill = [ChartFill fillWithLinearGradient:gradient1 angle:90.f];
//    set2.drawFilledEnabled = YES;
//    CGGradientRelease(gradient1);
    
    
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
     _lineChartView.data = [[LineChartData alloc] initWithDataSets:dataSets];
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
        DqyTotal *model = _model.dqyTotal;
        cell.srcNumLb.text = @"待签约订单";
        cell.numLb.text = [NSString stringWithFormat:@"%@单",@(model.num).stringValue];
        cell.srcMoneyLB.text = @"待签约金额";
        cell.moneyLB.text = [NSString stringWithFormat:@"%@元",[self moneyStr:model.actualAmount]];
    }else{
        YqyTotal *model = _model.yqyTotal;

        cell.srcNumLb.text = @"累计投资订单";
        cell.numLb.text = [NSString stringWithFormat:@"%@单",@(model.num).stringValue];
        cell.srcMoneyLB.text = @"累计投资金额";
        cell.moneyLB.text = [NSString stringWithFormat:@"%@元",[self moneyStr:model.actualAmount]];

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
