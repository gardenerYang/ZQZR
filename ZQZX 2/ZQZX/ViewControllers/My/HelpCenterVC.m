//
//  HelpCenterVC.m
//  ZQZX
//
//  Created by yangshuai on 2019/1/17.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "HelpCenterVC.h"
#import "ExpnadTableViewCell.h"
#import "FAQItem.h"

static NSString * const kBookCellIdentifier = @"ExpandCellIdentifier";

@interface HelpCenterVC ()
@property (strong, nonatomic) NSDictionary *faqDescription;
@property (strong, nonatomic) NSMutableSet *expandedIndexPaths;
@end

@implementation HelpCenterVC
@synthesize faqArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"帮助中心"] ;
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([ExpnadTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:kBookCellIdentifier];
    self.expandedIndexPaths = [NSMutableSet set];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    faqArray = [[NSMutableArray alloc]init];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 12)];
    view.backgroundColor = kTabBGColor;
    self.tableView.tableHeaderView = view;
    if (!_faqDescription) {
        _faqDescription = @{
                            @"1、如何注册成为平台会员？":@"进入票e通app，点击我的页面会弹出登陆页面，点击页面下方「立即注册」按钮会跳转到注册页面，根据页面提示完成注册即可",
                            @"2、如何修改绑定的手机号":@"进入票e通app，登陆后，点击我的页面，点击页面右上方「设置」图标>「安全设置」>「更换手机号码」>「修改」按提示更换手机号码。",
                            @"3、如何修改登录密码?":@"3.1、已知旧密码：进入票e通app，登陆后，点击我的页面，点击页面右上方「设置」图标>「安全设置」>「修改登录密码」>「修改」按提示填写新密码、原始密码。\n3.2、忘记旧密码：进入票e通app，点击我的页面会弹出登陆页面，点击页面中右方「忘记密码」按钮会跳转到找回密码页面，根据提示使用手机号找回密码。",
                            @"4、如何投资？":@"进入票e通app首页，成功登录后，点击上方投资栏目进入理财列表按页面提示进行投资即可。\n注：投资前必须进行实名认证，绑定好银行卡，完成以上操作才能开始真正的投资。募集中标为红色背景是代表该标的可投；若为灰色背景同时提示已募满，表示该标的不能再进行投资，请选择其他标的；若提示还款中或已还款表示后面还款的状态也不可投。\n确认投资金额后，点击预约，然后等待理财师受理并联系线下打款。投资成功后可以在「我的订单」查看投资情况。",
                            @"5、如何绑定银行卡？":@"进入票e通app我的页面，点击「绑定银行卡」>「添加银行卡」，根据页面提示添加银行卡即可，可添加多张，回款时会根据绑定的银行卡选择回款银行卡",
                            @"6、如何解绑银行卡？":@"进入票e通app我的页面，点击「绑定银行卡」，长按带背景的银行卡，会弹出解绑提示，点击解绑即可。",
                            @"7、投标后能否取消？":@"用户预约成功后订单为待受理状态，只有此时可以取消订单，用户线下打款后经理财师提交订单及打款凭证，则不可以取消订单，请谨慎选择您想要参与的标的！",
                            };
    }
    
    
    
    [self setupFAQWithDictinary:_faqDescription];
}

#pragma mark FAQ Model Setup with Dictiinary Method

-(void)setupFAQWithDictinary:(NSDictionary *)dictnary{
    NSArray *allQuestions =[[dictnary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [faqArray removeAllObjects];
    for (NSString *question in allQuestions) {
        FAQItem *objFaq = [[FAQItem alloc]init];
        objFaq.question = question;
        objFaq.answer = [dictnary valueForKey:question];
        [faqArray addObject:objFaq];
    }
    
}

#pragma mark FAQ Model Setup with Array Method

-(void)setupFAQWithArray:(NSArray *)question WithAnswer:(NSArray *)answer{
    [faqArray removeAllObjects];
    if (question.count == answer.count) {
        for (int i =0; i< question.count; i++) {
            FAQItem *objFaq = [[FAQItem alloc]init];
            objFaq.question = [question objectAtIndex:i];
            objFaq.answer = [answer objectAtIndex:i];
            [faqArray addObject:objFaq];
        }
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.faqArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpnadTableViewCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:kBookCellIdentifier];
    FAQItem *objFaq = [faqArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = objFaq.question;
    cell.DescriptionLabel.text = objFaq.answer;
    //cell.imageIcon.image = [UIImage imageNamed:@"expandGlyph"];
    cell.withDetails = [self.expandedIndexPaths containsObject:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([self.expandedIndexPaths containsObject:indexPath]) {
        
        ExpnadTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
        [self.expandedIndexPaths removeObject:indexPath];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        
        if (self.expandedIndexPaths.allObjects.count > 0) {
            
            NSIndexPath *removeExisting = self.expandedIndexPaths.allObjects[0];
            ExpnadTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:removeExisting];
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
            
            ExpnadTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
            [cell animateOpen];
        }
        
        
    }
}


@end
