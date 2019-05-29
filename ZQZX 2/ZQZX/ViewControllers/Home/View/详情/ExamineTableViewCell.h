//
//  ExamineTableViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExamineTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *dataArr;

@end

NS_ASSUME_NONNULL_END
