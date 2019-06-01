//
//  ProductModuleCell.h
//  ZQZX
//
//  Created by yangshuai on 2019/6/1.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductModuleCell : UITableViewCell
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier imageArray:(NSArray*)imageArray;
@property (nonatomic,strong)UIImageView * leftImageV;
@property (nonatomic,strong)UIImageView * rightImageV;
@end

NS_ASSUME_NONNULL_END
