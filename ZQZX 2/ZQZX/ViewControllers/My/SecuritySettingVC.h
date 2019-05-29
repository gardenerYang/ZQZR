//
//  SecuritySettingVC.h
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"
#import "BaseTableViewController.h"
#import "MyModel.h"
#if BusinessTag
#import "MyBusinessModel.h"

#else

#endif
NS_ASSUME_NONNULL_BEGIN

@interface SecuritySettingVC : BaseTableViewController
@property(nonatomic,strong)  MyModel *myModel;
#if BusinessTag
@property(nonatomic,strong)  MyBusinessModel *myBusinessModel;

#else

#endif
@end

NS_ASSUME_NONNULL_END
