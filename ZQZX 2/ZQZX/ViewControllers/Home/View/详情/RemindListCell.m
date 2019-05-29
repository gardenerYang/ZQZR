//
//  RemindListCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/4/19.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "RemindListCell.h"
#import "RemindListSelectView.h"
@implementation RemindListCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setModel:(InveItem *)model{
    if (self.selectView ==nil) {
        self.selectView = [[RemindListSelectView alloc]initWithFrame:CGRectMake(0, 0, 100, 30) withOption:model.operation];
        self.selectionStyle = 0;
        [self addSubview:self.selectView];
        [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-30);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        self.selectView.clipsToBounds = YES;
        __weak typeof(self) wf = self;

        self.selectView.selectOption = ^(NSInteger option) {
            model.operation = option;
            if (wf.selectOption) {
                wf.selectOption(option);
            };
        };
    }
    self.name.text = model.borrowName;
    self.orderNumber.text = [NSString stringWithFormat:@"订单号: %ld",model.investmentNo];
    self.money.text = [NSString stringWithFormat:@"金额: %ld元",model.capital];
}

@end
