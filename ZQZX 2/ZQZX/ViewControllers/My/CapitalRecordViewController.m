//
//  CapitalRecordViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "CapitalRecordViewController.h"
#import "CapitalRecordTableViewCell.h"
#import "MyRecordModel.h"
#import "HttpRequest+my.h"
#import "FAQItem.h"

@interface CapitalRecordViewController ()
@property(nonatomic,strong)NSMutableArray *dataListArr;
@property (strong, nonatomic) NSDictionary *faqDescription;
@property (strong, nonatomic) NSMutableSet *expandedIndexPaths;


@property(nonatomic,assign)int page;
@end

@implementation CapitalRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomerTitle: @"资金记录"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CapitalRecordTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CapitalRecordTableViewCell"];
    self.tableView.estimatedRowHeight = 44.f;
    self.expandedIndexPaths = [NSMutableSet set];
    __weak typeof(self) weakSelf = self;
    [self.tableView addMJ_Header:^{
        weakSelf.page=1;
        weakSelf.dataListArr=[[NSMutableArray alloc]init];
        [weakSelf requestList];
    }];
    [self.tableView addMJ_Footer:^{
        [weakSelf requestList];
    }];
    [self.tableView refresh];
}
-(void)requestList{
//    actualAmount = "312739.73";
//    addTime = 1548753952000;
//    capital = 300000;
//    id = 33;
//    interest = "12739.73";
//    productName = "\U6b63\U5f0f\U73af\U5883\U6d4b\U8bd5\U4fdd\U740602";
//    status = 2;
    __weak typeof(self) wf = self;
    [HttpRequest capitalRecordPageNum:_page Requestsuccess:^(MyRecordModel * _Nonnull model, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        
        if (self.page * 10 >= model.total) {
            [wf.tableView noMoreData];
        }else{
            wf.page ++;
            [wf.tableView resetMoreData];
        }
        [self.dataListArr addObjectsFromArray:model.cList];
        if (self.dataListArr.count == 0) {
            [wf addNodataView:@"norecord" : @"暂无l记录"  reload:^{
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
    //已签约 备注:当前已投资金额xxx元
    //已还款 备注:已还款金额xxx元.其中本金xxx元 利息xxx元
    //已赎回 备注:赎回通过,已返还金额xxx元.其中本金xxx元 利息xxx元
    CapitalRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CapitalRecordTableViewCell class]) forIndexPath:indexPath];
    cell.withDetails = [self.expandedIndexPaths containsObject:indexPath];
    MyRecordListModel *model = self.dataListArr[indexPath.row];
    cell.timeLab.text = [self parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.addTime] withType:kTimeStampWithSecond];
    cell.titleLabel.text = model.productName;
    if (model.status==0) {
        cell.moneyLab.textColor = [UIColor blackColor];
        cell.moneyLab.text = [NSString stringWithFormat:@"+%@",@(model.actualAmount).stringValue];
        cell.DescriptionLabel.text = [NSString stringWithFormat:@"\n备注:当前已投资金额%.2f元。\n",model.capital];
    }else if (model.status ==1){
        cell.moneyLab.textColor = [UIColor blackColor];
        cell.moneyLab.text = [NSString stringWithFormat:@"-%@",@(model.actualAmount).stringValue];
        cell.DescriptionLabel.text = [NSString stringWithFormat:@"\n备注:已还款金额%.2f元。其中本金%.2f元，利息%.2f元。\n",model.actualAmount,model.capital,model.interest];

    }else{
        cell.moneyLab.textColor = [UIColor m_red];
        cell.moneyLab.text = [NSString stringWithFormat:@"-%@",@(model.actualAmount).stringValue];
        cell.DescriptionLabel.text = [NSString stringWithFormat:@"\n备注:赎回通过,已返还金额%.2f元。其中本金%.2f元，利息%.2f元。\n",model.actualAmount,model.capital,model.interest];

    }
    return cell;
    
}

//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([self.expandedIndexPaths containsObject:indexPath]) {
        
        CapitalRecordTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
        [self.expandedIndexPaths removeObject:indexPath];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        
        if (self.expandedIndexPaths.allObjects.count > 0) {
            
            NSIndexPath *removeExisting = self.expandedIndexPaths.allObjects[0];
            CapitalRecordTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:removeExisting];
            [UIView animateWithDuration:0.3 animations:^{
                [self.expandedIndexPaths removeObject:removeExisting];
                [tableView reloadRowsAtIndexPaths:@[removeExisting] withRowAnimation:UITableViewRowAnimationNone];
            } completion:^(BOOL finished) {
                [self.expandedIndexPaths addObject:indexPath];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
            
            cell = (id)[tableView cellForRowAtIndexPath:indexPath];
        }
        else{
            [self.expandedIndexPaths addObject:indexPath];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            CapitalRecordTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
            [cell animateOpen];
        }
        
        
    }
}
@end
