//
//  RemindListVC.m
//  ZQZX
//
//  Created by yangshuai on 2019/4/18.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "RemindListVC.h"
#import "RemindListCell.h"
#import "RemindListFooterView.h"
#import "SuccessViewController.h"
@interface RemindListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) RemindListFooterView * footerView;
@property (nonatomic,assign) BOOL isAgree;

@end

@implementation RemindListVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = kTabBGColor;
    UIImageView * headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 205)];
    [self.view addSubview:headerView];
    headerView.image = kImageNamed(@"home_remind_list");
    UILabel * titleLal = [[UILabel alloc]init];
    [headerView addSubview:titleLal];
    titleLal.font = kFont(20);
    titleLal.textColor = [UIColor whiteColor];
    [titleLal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView).offset(-20);
        make.left.equalTo(headerView).offset(20);
        make.right.equalTo(headerView).offset(-20);
        
    }];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"以下订单请确认是否续投?"];
    NSRange range1 = [[str string] rangeOfString:@"续投?"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor withHexStr:@"fffc00"] range:range1];
    titleLal.attributedText = str;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, 140, kWidth-30, kHeight - 140)];
    [self.view addSubview:self.tableView];
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.cornerRadius = 5.0f;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"RemindListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RemindListCell"];
    [self setCustomerTitle:@"续投确认"];
    self.tableView.tableFooterView = self.footerView;
    __weak typeof(self) wf = self;

    [self.footerView.selectBtn addTapGestureBlock:^(UIView *view) {
        wf.footerView.selectBtn.selected = !wf.footerView.selectBtn.selected;
        wf.isAgree = wf.footerView.selectBtn.selected;
    }];
    [self.footerView.submitBtn addTapGestureBlock:^(UIView *view) {
        [wf submitData];
    }];
    [self.footerView.cancelBtn addTapGestureBlock:^(UIView *view) {
        [wf.navigationController popViewControllerAnimated:YES];
    }];
    [self.footerView.treatyBtn addTapGestureBlock:^(UIView *view) {
        [self gotoWebURL:user_xqCompact title:@"续投协议"];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RemindListCell *cell = [[NSBundle mainBundle]loadNibNamed:@"RemindListCell" owner:self options:0].lastObject;
    InveItem * model = self.listArray[indexPath.row];
    NSLog(@"+++++++++++%ld",model.operation);
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (RemindListFooterView *)footerView{
    if (_footerView==nil) {
        _footerView = [[[NSBundle mainBundle]loadNibNamed:@"RemindListFooterView" owner:self options:0] lastObject];
        [self.view addSubview:_footerView];
        _footerView.backgroundColor = [UIColor clearColor];
        [_footerView setFrame:CGRectMake(0, 0, kWidth, 200)];
      
    }
    return _footerView;
}
- (void)submitData{
    if (!self.isAgree) {
        [MBProgressHUD showWarnMessage:@"请勾选同意续投协议"];
        return;
    }
    NSMutableArray * jsonArray = [NSMutableArray array];
    for (InveItem * model in self.listArray) {
        NSDictionary * jsonDic = @{@"investmentId":[NSNumber numberWithInteger:model.id],
                                   @"operation":[NSNumber numberWithInteger:model.operation+1],
                                   };
        [jsonArray addObject:jsonDic];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray
                                                       options:kNilOptions
                                                         error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    NSDictionary * dic = @{@"investmentApplyforOperation":jsonString};
    [HttpRequest post:my_insertInvestmentApplyFor param:dic success:^(HttpResponse *data, NSString *message) {
        NSLog(@"%@",data.data);
        SuccessViewController *successVC=[[SuccessViewController alloc]init];
        successVC.titleLbText = @"续投成功";
        successVC.srcLbText = @"即将返回";
        [successVC setOtherblock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [successVC showInVC:self];
    } failure:^(NSError *error) {
        
    }];

}
@end
