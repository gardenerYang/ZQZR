//
//  RecordModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"
@class MyRecordListModel;
NS_ASSUME_NONNULL_BEGIN

@interface MyRecordModel : BaseClass
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , strong) NSArray <MyRecordListModel *>              * cList;
@property (nonatomic , assign) NSInteger              pageNum;
@end
@interface MyRecordListModel : BaseClass
@property (nonatomic , assign) CGFloat              actualAmount;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , assign) CGFloat              capital;
@property (nonatomic , assign) CGFloat              interest;
@property (nonatomic , assign) NSInteger              status;


@property (nonatomic , assign) NSInteger              addTime;

@end
NS_ASSUME_NONNULL_END
