//
//  InvestmentViewController.h
//  ZQZX
//
//  Created by 中企 on 2018/10/15.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InvestmentViewController : BaseTableViewController
/**
 类型
 */
@property(nonatomic,assign)NSInteger type;
- (instancetype)initType:(NSString *)type;
@property (nonatomic,assign)BOOL isShowTicket;
@end

NS_ASSUME_NONNULL_END
