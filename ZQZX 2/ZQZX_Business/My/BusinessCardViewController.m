//
//  BusinessCardViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/11/2.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BusinessCardViewController.h"
#import "SKPopAnimationMange.h"
#import "ZHPaymentTableViewCell.h"
@interface BusinessCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SKPopAnimationMange   *animationMange;
@property (nonatomic, strong) NSArray   *imgArr;
@property (nonatomic, strong) NSArray   *titleArr;
@property (nonatomic, strong) UIView   *bgView;
@property (nonatomic,strong) UITableView *tableView;
@property (strong, nonatomic) UIButton *doneButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (nonatomic,assign) NSInteger integerRow ;//如果是第一个默认选中
@end

@implementation BusinessCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArr = [NSArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1", nil];
    [self addUI];
}
-(void)addUI
{
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.tableView];
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.textColor=kTitleColor;
    self.titleLabel.font= [UIFont s14];
    self.titleLabel.text=@"请选择您的银行卡";
    [self.bgView addSubview:self.titleLabel];
    
    _doneButton = [[UIButton alloc] init];
    [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
    _doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_doneButton setTitleColor:kMainColor forState:UIControlStateNormal];
    [_doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.doneButton];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(IphoneHight/2);
        make.width.mas_equalTo(Iphonewidth);
        make.height.mas_equalTo(IphoneHight/2);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(150);
        make.centerX.mas_equalTo(self.bgView);
    }];
    
    [_doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(80);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.width.mas_equalTo(Iphonewidth);
        make.height.mas_equalTo(IphoneHight/2-60);
    }];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, Iphonewidth, IphoneHight/2) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor darkGrayColor]];
        [_tableView setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
        //cell无数据时，不显示间隔线
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //section
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _bankCardArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIde=@"cellIde";
    ZHPaymentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIde];
    if (cell==nil) {
        cell=[[ZHPaymentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary *dic = _bankCardArr[indexPath.row];
    cell.titleLabel.text=dic[@"bankNo"];
    cell.imageView.image=[UIImage imageNamed:_imgArr[indexPath.row]];
    if (_integerRow==indexPath.row) {
        cell.isSelected=YES;
    }
    else
    {
        cell.isSelected=NO;
        
    }
    cell.payBlock = ^(BOOL isSelec){
        
        _integerRow=indexPath.row;
        [tableView reloadData];
    };
    [cell reloadDataWith];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}

- (void)showInVC:(ZHViewController *)vc {
    [vc addChildViewController:self];
    [vc.view addSubview:self.view];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
    self.animationMange = [[SKPopAnimationMange alloc] init];
    self.animationMange.type = SK_ANIMATION_TYPE_ROTATION_LARGEN;
    self.animationMange.animationDirection = SK_ANIMATION_SUBTYPE_FROMBOTTOM;
    
    [self.animationMange animateWithView:self.bgView Duration:0.3 animationType:self.animationMange.type animationDirection:self.animationMange.animationDirection];
}

- (void)dismiss {
    [self.animationMange dismissAnimationForRootView:self.bgView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view removeFromSuperview];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView *view = [[touches anyObject] view];
    
    if ([view isEqual:self.view]) {
        [self dismiss];
    }
}
-(void)doneButtonClick
{
    [self dismiss];
    if (self.bankCardArr.count>0) {
        NSDictionary *dic = _bankCardArr[_integerRow];
        if (self.callBack) {
            self.callBack(dic[@"bankNo"]);
        }
    }else
    {
        if (self.callBack) {
            self.callBack(@"");
        }
    }
   
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
