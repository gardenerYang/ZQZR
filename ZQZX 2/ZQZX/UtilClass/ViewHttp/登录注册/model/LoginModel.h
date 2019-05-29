//
//  LoginModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/25.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : NSObject
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * headPortraitUrl;
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , copy) NSString              * idNo;

#if BusinessTag
@property (nonatomic , copy) NSString              * referralCode;
@property (nonatomic , assign) BOOL              isLock;
@property (nonatomic , assign) NSInteger              lockTime;
@property (nonatomic , assign) NSInteger              employeesNo;
@property (nonatomic , copy) NSString              *  username;
@property (nonatomic , copy) NSString              *  handImageUrl;

#else

#endif
//以下是理财师登录使用/////////

@end

NS_ASSUME_NONNULL_END
