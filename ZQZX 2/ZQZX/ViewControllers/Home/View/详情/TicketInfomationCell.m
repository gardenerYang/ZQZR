//
//  TicketInfomationCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/1/17.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "TicketInfomationCell.h"
@implementation TicketInfomationCell

- (void)awakeFromNib {
    [super awakeFromNib];

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        self.imageV = [[UIImageView alloc]init];
        [self addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(self).offset(10);
            make.right.mas_equalTo(self).offset(-10);
            make.bottom.mas_equalTo(-10);
        }];
        self.backgroundColor = kTabBGColor;
     
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
