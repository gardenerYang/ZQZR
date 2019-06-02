//
//  ProductListCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/6/1.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "ProductListCell.h"

@implementation ProductListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = NO;
    self.backgroundColor = kTabBGColor;
    self.imageV.layer.masksToBounds = YES;
    self.imageV.layer.cornerRadius = 5.0f;
    self.moneyLabel.textColor = kMainColor;
}

-(void)setModel:(CListItem *)model{
    [self.imageV sd_setImageWithURL:kURL(model.imageUrl) placeholderImage:kNewsPlaceholderImage];
    self.prodeuctName.text = model.name;
    self.productTitle.text = model.introduction;
    CGFloat per = (model.actualTotalAmount-model.reservationAmount)/model.proTotalAmount;
    NSString * perString = @"%";
    self.moneyLabel.text = [NSString stringWithFormat:@"%.f%@",per*100,perString];
}
@end
