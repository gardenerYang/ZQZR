//
//  AaaBankCardViewController.h
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHViewController.h"
#import "MyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddBankCardViewController : ZHViewController
@property(nonatomic,strong)  MyModel *myModel;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , copy) NSString              * idNo;
@end

NS_ASSUME_NONNULL_END
