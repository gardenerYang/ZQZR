//
//  HomeVersionCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/5/30.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "HomeVersionCell.h"

@implementation HomeVersionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
        self.backgroundColor = kTabBGColor;
    }
    return self;
}
- (void)createUI{
    self.selectionStyle = NO;
    self.imageV = [[UIImageView alloc]init];
    [self addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-15);
    }];
    self.imageV.image = kImageNamed(@"version_image");
    
}
@end
