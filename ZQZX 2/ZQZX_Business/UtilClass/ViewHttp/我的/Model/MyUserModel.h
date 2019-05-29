//
//  MyUserModel.h
//  ZQZX
//
//  Created by 中企 on 2018/11/1.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyUserModel : BaseClass
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * realName;
@end

NS_ASSUME_NONNULL_END
