//
//  QNModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNModel : BaseClass
/**
 七牛token
 */
@property (nonatomic , copy) NSString              * token;
/**
 七牛域名
 */
@property (nonatomic , copy) NSString              * doman;

@end

NS_ASSUME_NONNULL_END
