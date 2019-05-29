//
//  UICollectionView+Register.h
//  Ninesecretary
//
//  Created by JG on 2017/10/25.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Register)

@property (nonatomic, assign) BOOL refreshing;

- (void)registerClass:(Class)cellClass;
- (id)dequeueReusableClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;
- (void)registerHeader:(Class)classes;
- (id)dequeueReusableHeader:(Class)headerClass forIndexPath:(NSIndexPath *)indexPath;
- (void)registerFooter:(Class)classes;
- (id)dequeueReusableFooter:(Class)footerClass forIndexPath:(NSIndexPath *)indexPath;
- (void)addMJ_Header:(void (^)(void))begin;
- (void)addMJ_Footer:(void (^)(void))begin;
- (void)refresh;
- (void)loadMore;
- (void)stopReload;

- (void)noMoreData;
- (void)resetMoreData;
- (void)addNoDataView:(NSString *)title;
- (void)removeNoDataView;

@end
