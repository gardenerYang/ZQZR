//
//  ActivityListCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/6/1.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "ActivityListCell.h"

@implementation ActivityListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ActiveModel *)model{
    [self.activityImage sd_setImageWithURL:kURL(model.imageUrl) placeholderImage:kNewsPlaceholderImage];
//    self.activityState
    
}
@end
