//
//  BusinessReplacePhoneVC.h
//  ZQZX
//
//  Created by 中企 on 2018/11/3.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"
#import "MyBusinessModel.h"

typedef NS_ENUM(NSUInteger, BusinessReplacePhoneType) {
    BusinessReplacePhoneType_Code,
    BusinessReplacePhoneType_Phone_Code,
};
NS_ASSUME_NONNULL_BEGIN

@interface BusinessReplacePhoneVC : ZHViewController
- (instancetype)init:(BusinessReplacePhoneType)type;
@property(nonatomic,strong)MyBusinessModel *myModel;

@end

NS_ASSUME_NONNULL_END
