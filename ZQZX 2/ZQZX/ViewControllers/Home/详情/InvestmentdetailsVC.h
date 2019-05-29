//
//  InvestmentdetailsVC.h
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InvestmentdetailsVC : ZHViewController
@property(nonatomic,strong)NSString *productID;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,assign)NSInteger type;//0-4

//@property(nonatomic,assign)BOOL isShowTicket;//1有票面信息 0没有


@end

NS_ASSUME_NONNULL_END
