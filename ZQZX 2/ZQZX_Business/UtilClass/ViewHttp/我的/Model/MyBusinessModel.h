//
//  MyBusinessModel.h
//  ZQZX_Business
//
//  Created by 中企 on 2018/11/1.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyBusinessModel : BaseClass
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * headImageUrl;
@property (nonatomic , assign) NSInteger              lockTime;
@property (nonatomic , copy) NSString              * referralCode;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , assign) NSInteger              rate;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , copy) NSString              * lockRemark;
@property (nonatomic , copy) NSString              * levelName;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * employeesNo;
@property (nonatomic , copy) NSString              * businessDepartment;
@property (nonatomic , assign) NSInteger              corpId;
@property (nonatomic , assign) BOOL              isLock;
@property (nonatomic , assign) NSInteger              userCount;
@property (nonatomic , copy) NSString              * idNo;
@property (nonatomic , assign) NSInteger              superiorId;
@property (nonatomic , copy) NSString              * largeArea;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * superiorName;
@property (nonatomic , copy) NSString              * email;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , assign) NSInteger              addTime;


@end

NS_ASSUME_NONNULL_END
