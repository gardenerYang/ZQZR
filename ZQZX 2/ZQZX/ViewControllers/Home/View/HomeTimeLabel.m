//
//  HomeTimeLabel.m
//  ZQZX
//
//  Created by yangshuai on 2019/3/14.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "HomeTimeLabel.h"

@implementation HomeTimeLabel

- (void)setupProperty{
    self.timeKey = @"endTime";
    //设置过时数据自动删除
    self.isAutomaticallyDeleted = YES;
    //设置自定义时间样式，还需要实现ZJJTimeCountDownDelegate自定义文本方法，这样自定义文本才会生效
    self.textStyle = ZJJTextStlyeCustom;
}

@end
