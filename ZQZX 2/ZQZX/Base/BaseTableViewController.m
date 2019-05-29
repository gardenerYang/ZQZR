//
//  BaseTableViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/15.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()<UITableViewDelegate, UITableViewDataSource>  {
    UITableViewStyle    _style;
}
@property (nonatomic, assign) BOOL isCanbeNoMoreData;

@end

@implementation BaseTableViewController

- (Class)tableViewClass {
    return [UITableView class];
}

- (instancetype)init {
    return [self initWithTableStyle:UITableViewStylePlain];
}

- (instancetype)initWithTableStyle:(UITableViewStyle)style {
    self = [super init];
    
    if (self) {
        if (style == UITableViewStylePlain || style == UITableViewStyleGrouped) {
            _style = style;
        } else {
            _style = UITableViewStylePlain;
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCanbeNoMoreData = NO;
    [JGNotifyCenter addObserver:self selector:@selector(noMoreDataWithNotify:) name:JGTableNoMoreData object:nil];
    _tableView = [[[self tableViewClass] alloc] initWithFrame:CGRectZero style:_style];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedRowHeight = 0;
    _tableView.dataSource= (id<UITableViewDataSource>)self;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = nil;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.animationType = TableViewAnimationTypeMoveSpring;
    [self.view addSubview:_tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isCanbeNoMoreData = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isCanbeNoMoreData = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)noMoreDataWithNotify:(NSNotification *)nofity {
    if (self.isCanbeNoMoreData) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)reloadControllerData {
    [self.tableView refresh];
}

//MARK: ----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)setTableViewEdges:(UIEdgeInsets)edges {
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(edges.top);
        make.left.mas_equalTo(edges.left);
        make.bottom.mas_equalTo(-edges.bottom);
        make.right.mas_equalTo(-edges.right);
    }];
}

- (UIView *)findFirstResponderBeneathView:(UIView *)view {
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result ) return result;
    }
    return nil;
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
