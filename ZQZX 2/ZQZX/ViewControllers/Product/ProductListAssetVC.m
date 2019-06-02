//
//  ProductListAssetVC.m
//  ZQZX
//
//  Created by yangshuai on 2019/6/2.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "ProductListAssetVC.h"
#import "ProductListCell.h"
#import "HomeListModel.h"
#import "HttpRequest+Home.h"
#import "ZJJTimeCountDown.h"
@interface ProductListAssetVC ()<ZJJTimeCountDownDelegate>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray *timeListArr;
@property(nonatomic,strong)NSString *productType;//产品类型
@property(nonatomic,assign)int page;
@property(nonatomic,strong) ZJJTimeCountDown * countDown;

@end

@implementation ProductListAssetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.timeListArr = [NSMutableArray array];
    [self createUI];
}

- (void)createUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ProductListCell"];
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    @weakify(self);
    [self.tableView addMJ_Header:^{
        @strongify(self);
        self.page=1;
        self.dataArray=[[NSMutableArray alloc]init];
        [self requestList];
    }];
    [self.tableView addMJ_Footer:^{
        @strongify(self);
        [self requestList];
    }];
    [self.tableView refresh];

}
-(void)requestList{
    __weak typeof(self) wf = self;
    [HttpRequest getHomeListPageNum:_page type:@"0" Requestsuccess:^(HomeListModel * _Nonnull model, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        
        if (self.page * 10 >= model.total) {
            [wf.tableView noMoreData];
        }else{
            wf.page ++;
            [wf.tableView resetMoreData];
        }
        [self.dataArray addObjectsFromArray:model.cList];
        if (self.dataArray.count == 0) {
            [wf addNodataView:@"nopro" : @"暂无产品"  reload:^{
                [wf requestList];
            }];
        }else{
            [wf hideNoDataView];
        }
        for (CListItem * item in self.dataArray) {
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kWidth-30)*173/345;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductListCell"];
    //一定要设置，设置时间数据
    timeModel *timemodel = self.timeListArr[indexPath.row];
    [cell.timeMoudle setupCellWithModel:timemodel indexPath:indexPath];
    //在不设置为过时自动删除情况下 设置该方法后，滑动过快的时候时间不会闪情况
    cell.timeMoudle.attributedText = [self.countDown countDownWithTimeLabel:cell.timeMoudle];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
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
    NSDictionary *datedic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:kMainColor};
    NSMutableAttributedString *dateAtt = [[NSMutableAttributedString alloc] init];
    [texts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *text = (NSString *)obj;
        //说明是时间字符串
        if ([text integerValue] || [text rangeOfString:@"0"].length) {
            [dateAtt appendAttributedString:[[NSAttributedString alloc] initWithString:text attributes:datedic]];
        }else{
            [dateAtt appendAttributedString:[[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:kMainColor}]];
        }
        
    }];
    return dateAtt;
}
@end
