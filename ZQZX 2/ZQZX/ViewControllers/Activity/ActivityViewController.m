//
//  ActivityViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityTableViewCell.h"
#import "HttpRequest+Active.h"
@interface ActivityViewController ()
@property(nonatomic,strong)NSMutableArray *dataListArr;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomerTitle:@"活动"];
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ActivityTableViewCell class])];
    __weak typeof(self) weakSelf = self;
    [self.tableView addMJ_Header:^{
        weakSelf.dataListArr=[[NSMutableArray alloc]init];
        [weakSelf requestList];
    }];
 
    [self.tableView refresh];
}
-(void)requestList{
    __weak typeof(self) wf = self;

    [HttpRequest getActiveDataRequestsuccess:^(NSArray * _Nonnull dataArr, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        [self.dataListArr addObjectsFromArray:dataArr];
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
    
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ActivityTableViewCell class]) forIndexPath:indexPath];
    ActiveModel *model = _dataListArr[indexPath.row];
    cell.titleLb.text= model.title;
    if (model.activityStatus.intValue == 0) {
        [cell isStatelayout];
        [cell.timeLabel_hsf setcurentTime:model.numberDay.intValue];
    }
    [cell.bgimgView sd_setBigImageWithString:model.imageUrl];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActiveModel *model = _dataListArr[indexPath.row];
    [self gotoWebURL:model.url htmlText:model.introduction  title:@""];

    
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
