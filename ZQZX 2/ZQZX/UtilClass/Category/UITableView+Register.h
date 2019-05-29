//
//  UITableView+Register.h
//  Ninesecretary
//
//  Created by JG on 2017/10/26.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoDataView.h"
@interface UITableView (Register)

@property (nonatomic, assign) BOOL refreshing;

- (void)registerClass:(Class)cellClass;
- (id)dequeueReusableCellClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;
- (void)registerHeader:(Class)classes;
- (id)dequeueReusableHeader:(Class)headerClass;
- (void)registerFooter:(Class)classes;
- (id)dequeueReusableFooter:(Class)footerClass;
- (void)addMJ_Header:(void (^)(void))begin;
- (void)addMJ_Footer:(void (^)(void))begin;
- (void)refresh;
- (void)loadMore;
- (void)stopReload;

- (void)noMoreData;
- (void)resetMoreData;

- (void)addNoDataView:(NSString *)title;
- (void)addNoDataView:(NSString *)title image:(NSString *)image;
- (void)addNoDataDetailNews;
- (void)addNodata;
- (void)addNoDataDetailShopping;
- (void)removeNoDataView;

@end
