//
//  ReplacePhoneViewController.h
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"


typedef NS_ENUM(NSUInteger, ReplacePhoneType) {
    ReplacePhoneType_Code,
    ReplacePhoneType_Phone_Code,
};
NS_ASSUME_NONNULL_BEGIN

@interface ReplacePhoneViewController : ZHViewController
- (instancetype)init:(ReplacePhoneType)type;
@end

NS_ASSUME_NONNULL_END
