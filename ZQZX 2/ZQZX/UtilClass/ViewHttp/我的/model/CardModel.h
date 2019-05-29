//
//  CardModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/26.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardModel : BaseClass
@property (nonatomic , copy) NSString              * bank;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) BOOL              type;
@property (nonatomic , assign) NSString              *bankNo;

@end

NS_ASSUME_NONNULL_END
