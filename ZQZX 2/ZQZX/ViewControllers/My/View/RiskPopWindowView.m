//
//  RiskPopWindowView.m
//  ZQZX
//
//  Created by yangshuai on 2019/1/23.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "RiskPopWindowView.h"

@implementation RiskPopWindowView


- (void)drawRect:(CGRect)rect {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    self.textView.editable = NO;
    [self.textView scrollRangeToVisible:NSMakeRange(0,1)];
}

@end
