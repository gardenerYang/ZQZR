//
//  BankCardViewController.h
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BankCardViewController : BaseTableViewController
@property(nonatomic,strong)  MyModel *myModel;
@property (nonatomic,  copy) NSString * name;
@property (nonatomic,  copy) NSString * idCard;

@end

NS_ASSUME_NONNULL_END
