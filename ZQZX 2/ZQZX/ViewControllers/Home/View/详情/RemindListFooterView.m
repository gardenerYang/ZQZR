//
//  RemindListFooterView.m
//  ZQZX
//
//  Created by yangshuai on 2019/4/21.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "RemindListFooterView.h"

@implementation RemindListFooterView


- (void)drawRect:(CGRect)rect {
    [self.selectBtn setImage:kImageNamed(@"unchecked.png") forState:(UIControlStateNormal)];
    [self.selectBtn setImage:kImageNamed(@"checked.png") forState:(UIControlStateSelected)];
    self.cancelBtn.layer.borderColor = [UIColor withHexStr:@"d4d4d4"].CGColor;
    self.cancelBtn.layer.borderWidth = 0.5f;

}


@end
