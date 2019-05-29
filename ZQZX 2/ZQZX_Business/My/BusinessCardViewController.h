//
//  BusinessCardViewController.h
//  ZQZX
//
//  Created by 中企 on 2018/11/2.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BusinessCardViewController : ZHViewController
@property (nonatomic,strong)NSArray *bankCardArr;
@property(nonatomic,copy)void (^callBack)(NSString *bankCard);
- (void)showInVC:(ZHViewController *)vc;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
