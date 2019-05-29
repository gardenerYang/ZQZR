//
//  TicketInformationVC.m
//  ZQZX
//
//  Created by yangshuai on 2019/1/17.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "TicketInformationVC.h"
#import "TicketInfomationCell.h"
@interface TicketInformationVC ()

@end

@implementation TicketInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableViewEdges:UIEdgeInsetsMake(0 , 0, 0, 0)];
    [self.tableView registerClass:[TicketInfomationCell class] forHeaderFooterViewReuseIdentifier:@"TicketInfomationCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketInfomationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TicketInfomationCell"];
    
    return cell;
}


//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

@end
