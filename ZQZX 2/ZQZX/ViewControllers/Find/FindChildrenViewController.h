//
//  FindChildrenViewController.h
//  ZQZX
//
//  Created by 中企 on 2018/10/16.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FindChildrenViewController : BaseTableViewController
- (instancetype)init:(NSString *)type ;
@property (nonatomic, copy) void (^backImgblock)(NSString *bannerUrl,NSString *Url,NSString *content);

@end

NS_ASSUME_NONNULL_END
