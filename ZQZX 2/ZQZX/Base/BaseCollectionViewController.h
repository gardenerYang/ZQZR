//
//  BaseCollectionViewController.h
//  ZQZX
//
//  Created by 中企 on 2018/10/22.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"
#import "UICollectionView+Register.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewController : ZHViewController
@property (nonatomic, strong) UICollectionView *collectionView;

- (UICollectionViewLayout *)collectionViewLayout;
- (void)setViewEdges:(UIEdgeInsets)edges;
@end

NS_ASSUME_NONNULL_END
