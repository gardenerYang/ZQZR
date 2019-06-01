//
//  BankCardViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BankCardViewController.h"
#import "UIButton+SSEdgeInsets.h"
#import "BankCardTableViewCell.h"
#import "AddBankCardViewController.h"
#import "HttpRequest+my.h"
#import "AppUserProfile.h"
@interface BankCardViewController ()
@property(nonatomic,strong)NSArray *imgArr;
@property(nonatomic,strong)NSMutableArray *dataListArr;

@end

@implementation BankCardViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView refresh];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor m_bgColor];
    _imgArr = [NSArray arrayWithObjects:@"cell_bg_red",@"cell_bg_blue",@"cell_bg_green", nil];
    [self setCustomerTitle:@"银行卡"];
    [self addUI];
}
-(void)requestList{
    __weak typeof(self) wf = self;

    [HttpRequest getCardListRequestsuccess:^(NSArray * _Nonnull cardArr, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        [self.dataListArr addObjectsFromArray:cardArr];
        [wf.tableView reloadData];

    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
        [wf.tableView stopReload];
    }];
}
-(void)addUI{
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[BankCardTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BankCardTableViewCell class])];

    
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Iphonewidth, 100)];
    footview.userInteractionEnabled = YES;
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setBackgroundColor:[UIColor whiteColor]];
    [addBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"addCard"] forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor m_textDeepGrayColor] forState:UIControlStateNormal];
    [addBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:10];
    addBtn.layer.masksToBounds = YES;
    addBtn.layer.cornerRadius = 5;
    __weak typeof(self) wf = self;
    [addBtn addAction:^(UIButton *sender) {
        AddBankCardViewController *AddBankCardVC =[[AddBankCardViewController alloc]init];
        AddBankCardVC.myModel = wf.myModel;
        AddBankCardVC.idNo = [AppUserProfile sharedInstance].idNo;
        AddBankCardVC.realName = [AppUserProfile sharedInstance].realName;
        [wf.navigationController pushViewController:AddBankCardVC animated:YES];
    }];
    [footview addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(60);
        make.right.mas_equalTo(-10);
    }];
    self.tableView.tableFooterView=footview;
    __weak typeof(self) weakSelf = self;
    [self.tableView addMJ_Header:^{
        weakSelf.dataListArr=[[NSMutableArray alloc]init];
        [weakSelf requestList];
    }];
    
//    [self.tableView refresh];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BankCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BankCardTableViewCell class]) forIndexPath:indexPath];
    CardModel *model = self.dataListArr[indexPath.row];
    int value = indexPath.row % (3);

    cell.bgImgView.image = [UIImage imageNamed:_imgArr[value]];
    cell.titleLb.text = model.bank;
    cell.srcLb.text = model.type ?  @"回款银行卡" : @"其他银行卡";
    cell.numLb.text =model.bankNo;
    [cell.photoImgView sd_setImageWithString:@""];
    return cell;
    
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *delete = [UITableViewRowAction             rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //当点击删除执行块中的内容
        CardModel *model = self.dataListArr[indexPath.row];
        [MBProgressHUD showActivityMessageInView:@"正在解绑..."];

        [HttpRequest deleteCardID:@(model.id).stringValue Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
             [MBProgressHUD hideHUD];
            [self.dataListArr removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD showErrorMessage:error.localizedDescription];
        }];
        
         }];
    delete.backgroundColor = kMainColor;
        return @[delete];
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
