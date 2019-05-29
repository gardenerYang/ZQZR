//
//  ZHPaymentTableViewCell.h
//  Ninesecretary
//
//  Created by chenglian on 2017/11/3.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ZHPayBlock)(BOOL select);

@interface ZHPaymentTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;
@property (nonatomic, strong)UIButton *bigSelectBtn;
@property (nonatomic,assign)BOOL isSelected;
@property (nonatomic,copy)ZHPayBlock payBlock;
-(void)reloadDataWith;
@end
