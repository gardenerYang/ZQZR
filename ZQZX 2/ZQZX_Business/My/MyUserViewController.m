//
//  MyUserViewController.m
//  ZQZX_Business
//
//  Created by 中企 on 2018/10/23.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyUserViewController.h"
#import "MyUserTableViewCell.h"
#import "HttpRequest+MyBusiness.h"
@interface MyUserViewController ()
@property(nonatomic,strong)NSMutableArray *dataListArr;

@end

@implementation MyUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomerTitle:@"我的用户"];
    __weak typeof(self) wf = self;

    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[MyUserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MyUserTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.tableView.tableFooterView = [UIView new];
    [self.tableView addMJ_Header:^{
        wf.dataListArr=[[NSMutableArray alloc]init];
        [wf requestList];
    }];
   
    [self.tableView refresh];
}
-(void)requestList{
    __weak typeof(self) wf = self;
    [HttpRequest getMyUserRequestsuccess:^(NSArray * _Nonnull arr , NSString * _Nonnull message) {
        [wf.tableView stopReload];
        [self.dataListArr addObjectsFromArray:arr];
        if (self.dataListArr.count == 0) {
            [wf addNodataView:@"norecord" : @"暂无数据"  reload:^{
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
    
    MyUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyUserTableViewCell class]) forIndexPath:indexPath];
    MyUserModel *model = self.dataListArr[indexPath.row];
    cell.nameLb.text = model.realName;
    cell.phoneLb.text = model.phone;
    cell.cityLb.text = model.province;
    return cell;
    
}

//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
