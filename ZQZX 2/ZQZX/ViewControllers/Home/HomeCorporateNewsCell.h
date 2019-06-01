//
//  HomeCorporateNewsCell.h
//  ZQZX
//
//  Created by yangshuai on 2019/5/30.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCorporateNewsCell : UITableViewCell
@property (nonatomic,strong) ListItem * model;
@property (weak, nonatomic) IBOutlet UILabel *news_title;
@property (weak, nonatomic) IBOutlet UIImageView *news_image;
@end

NS_ASSUME_NONNULL_END
