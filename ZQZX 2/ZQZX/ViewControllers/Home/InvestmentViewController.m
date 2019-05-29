//
//  InvestmentViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/15.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "InvestmentViewController.h"
#import "FinancingTableViewCell.h"
#import "BillDetailsViewController.h"
#import "HeadswitchBtnView.h"
#import "HttpRequest+Home.h"
#import "HomeListModel.h"
#import "NSString+Validation.h"
#import "ZJJTimeCountDown.h"
@interface InvestmentViewController ()<ZJJTimeCountDownDelegate>
{

    
}
@property(nonatomic,strong)NSString *productType;//产品类型
@property(nonatomic,strong)NSMutableArray *dataListArr;
@property(nonatomic,strong)NSMutableArray *timeListArr;

@property(nonatomic,assign)int page;
@property(nonatomic,strong) ZJJTimeCountDown * countDown;

@end

@implementation InvestmentViewController

- (instancetype)initType:(NSString *)type{
    self = [super init];

    if (self) {
        _productType = type;

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeListArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor m_bgColor];
    [self initUI];
}
- (void)initUI {
     __weak typeof(self) wf = self;

    [self setTableViewEdges:UIEdgeInsetsMake(@(_type).intValue == 1 ? 0 : 74, 0, 0, 0)];

    [self.tableView registerClass:[FinancingTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FinancingTableViewCell class])];
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
    [HttpRequest getHomeListPageNum:_page type:_productType Requestsuccess:^(HomeListModel * _Nonnull model, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        
        if (self.page * 10 >= model.total) {
            [wf.tableView noMoreData];
        }else{
            wf.page ++;
            [wf.tableView resetMoreData];
        }
        [self.dataListArr addObjectsFromArray:model.cList];
        if (self.dataListArr.count == 0) {
            [wf addNodataView:@"nopro" : @"暂无产品"  reload:^{
                [wf requestList];
            }];
        }else{
            [wf hideNoDataView];
        }
        for (CListItem * item in self.dataListArr) {
            timeModel * model = [[timeModel alloc]init];
            if (item.status==1) {
                model.startTime = [self getNowTimeTimestamp];
                model.endTime = [self getEndTimeTimestampWithremainingCollectionTime:item.remainingCollectionTime.floatValue];
            }else{
                model.startTime = @"0";
                model.endTime = @"0";
            }
            [self.timeListArr addObject:model];
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
   
    FinancingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FinancingTableViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor=[UIColor m_bgColor];
    CListItem *model = _dataListArr[indexPath.row];
    cell.titleLabel.text = model.name;
    cell.numLb.text =  [NSString stringFormatPercentNumberWithFloat:@(model.expectedYield).floatValue];
    cell.dayLb.text = [NSString stringWithFormat:@"%ld天",(long)model.projectDuration];
    //一定要设置，设置时间数据
    timeModel *timemodel = self.timeListArr[indexPath.row];
    //一定要设置，设置时间数据
    cell.moneyLb.text =[NSString stringWithFormat:@"%@起投",[self moneyStr:model.purchaseAmount]];
    CGFloat per = (model.actualTotalAmount-model.reservationAmount)/model.proTotalAmount;
    NSLog(@"%f",per);
    cell.progressView.progress = per;
    NSString * perString = @"%";
    cell.progressLabel.text = [NSString stringWithFormat:@"预约进度:%.f%@",per*100,perString];
    NSString *stateText;
    [cell.timeLb setupCellWithModel:timemodel indexPath:indexPath];
    //在不设置为过时自动删除情况下 设置该方法后，滑动过快的时候时间不会闪情况
    cell.timeLb.attributedText = [self.countDown countDownWithTimeLabel:cell.timeLb];
    if (@(model.status).intValue == 1) {
        stateText = @"募集中";
    }else if (@(model.status).intValue == 4){
        stateText = @"还款中";
        cell.stateLb.backgroundColor = [UIColor withHexStr:@"#469ee8"];
    }else if (@(model.status).intValue == 3){
        stateText = @"已募满";
    }
    else if (@(model.status).intValue == 6){
        stateText = @"已还款";
    }
    else {
    }
    cell.stateLb.text = stateText;
    if (model.platformRateYear > 0) {
        cell.interestsLb.hidden = NO;
    }else{
        cell.interestsLb.hidden = YES;
    }
    return cell;
    
}

//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CListItem *model = _dataListArr[indexPath.row];
    InvestmentdetailsVC *investmentdetailsVC = [[InvestmentdetailsVC alloc]init];
    investmentdetailsVC.productID = @(model.id).stringValue;
    investmentdetailsVC.status = model.status;
    investmentdetailsVC.type = model.type;
    [investmentdetailsVC setCustomerTitle:model.name];
    [self.navigationController pushViewController:investmentdetailsVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (ZJJTimeCountDown *)countDown{
    
    if (!_countDown) {
        _countDown = [[ZJJTimeCountDown alloc] initWithScrollView:self.tableView dataList:self.timeListArr];
        _countDown.delegate = self;
        _countDown.timeStyle = ZJJCountDownTimeStyleTamp;

    }
    return _countDown;
}

- (NSAttributedString *)customTextWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown{
    
    NSArray *textArray = @[[NSString stringWithFormat:@"%.2ld",timeLabel.days],
                           @"天",
                           [NSString stringWithFormat:@"%.2ld",timeLabel.hours],
                           @"小时",
                           [NSString stringWithFormat:@"%.2ld",timeLabel.minutes],
                           @"分",
                           [NSString stringWithFormat:@"%.2ld",timeLabel.seconds],
                           @"秒"];
    
    return [self dateAttributeWithTexts:textArray];
}
- (NSAttributedString *)dateAttributeWithTexts:(NSArray *)texts{
    NSDictionary *datedic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:10],NSForegroundColorAttributeName:[UIColor withHexStr:@"469ee8"]};
    NSMutableAttributedString *dateAtt = [[NSMutableAttributedString alloc] init];
    [texts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *text = (NSString *)obj;
        //说明是时间字符串
        if ([text integerValue] || [text rangeOfString:@"0"].length) {
            [dateAtt appendAttributedString:[[NSAttributedString alloc] initWithString:text attributes:datedic]];
        }else{
            [dateAtt appendAttributedString:[[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor withHexStr:@"737373"]}]];
        }
        
    }];
    return dateAtt;
}
- (NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}
- (NSString *)getEndTimeTimestampWithremainingCollectionTime:(CGFloat)time{
    CGFloat  number = [self getNowTimeTimestamp].floatValue;
    NSString * timeSp = [NSString stringWithFormat:@"%.f", number + time];
    return timeSp;
}
@end
