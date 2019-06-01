//
//  FindChildrenViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/16.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "FindChildrenViewController.h"
#import "HomeFineTableViewCell.h"
#import "HttpRequest+Find.h"
#import "FindModel.h"
#import "UIViewController+Util.h"
@interface FindChildrenViewController ()
@property(nonatomic,strong)NSMutableArray *dataListArr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSString *type;

@end

@implementation FindChildrenViewController


- (instancetype)init:(NSString *)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[HomeFineTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeFineTableViewCell class])];
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
    __weak typeof(self) wf = self;
    [HttpRequest getFindDataPageNum:_page type:_type home:@"" Requestsuccess:^(FindModel * _Nonnull findMode, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        if (self.page * 10 >= findMode.total) {
            [wf.tableView noMoreData];
        }else{
            wf.page ++;
            [wf.tableView resetMoreData];
        }
        [self.dataListArr addObjectsFromArray:findMode.cList];
        if (self.dataListArr.count == 0) {
            [wf addNodataView:@"NodataImage" :wf.type.intValue == 1 ? @"暂无行业新闻数据" : @"暂无公司动态数据" reload:^{
                [wf requestList];
            }];
        }else{
            [wf hideNoDataView];
        }
        [wf.tableView reloadData];
        if (wf.backImgblock) {
            wf.backImgblock(findMode.bannerUrl,findMode.url,findMode.content);
        }
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
    
    HomeFineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeFineTableViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor=[UIColor m_bgColor];
    ListItem *model = _dataListArr[indexPath.row];
    [cell.imgView sd_setNewsImageWithString:model.imageUrl];
    cell.titleLabel.text = model.title;
    cell.timeLabel.text = [self parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.addTime] withType:kTimeStampDateOnlyTextLine];
    return cell;
    
}


//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ListItem *model = _dataListArr[indexPath.row];
    [self gotoWebURL:model.urlHref htmlText:model.content  title:@""];
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
