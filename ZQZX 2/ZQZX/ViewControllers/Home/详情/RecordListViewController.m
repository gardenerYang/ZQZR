//
//  RecordListViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "RecordListViewController.h"
#import "RecordListTableViewCell.h"
@interface RecordListViewController ()

@end

@implementation RecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTableViewEdges:UIEdgeInsetsMake(0 , 0, 0, 0)];
    
    [self.tableView registerClass:[RecordListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([RecordListTableViewCell class])];
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
 
        RecordListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecordListTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.nameLb.text = @"预约人";
        cell.moneyLb.text = @"预约金额";
        cell.timeLb.text = @"预约时间";
        cell.nameLb.font = [UIFont s16];
        cell.nameLb.textColor = [UIColor blackColor];
        cell.timeLb.font = [UIFont s16];
        cell.timeLb.textColor = [UIColor blackColor];
        cell.moneyLb.font = [UIFont s16];
        cell.moneyLb.textColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor m_bgColor];
    }else{
        cell.nameLb.text = @"13937187606";
        cell.moneyLb.text = @"10000.00";
        cell.timeLb.text = @"2019.09.09 11:11";
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
