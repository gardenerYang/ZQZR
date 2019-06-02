//
//  HomeListModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN
@class CListItem;
@interface HomeListModel : BaseClass
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , strong) NSArray <CListItem *>              * cList;
@property (nonatomic , assign) NSInteger              pageNum;

@end
@interface CListItem :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              purchaseAmount;
@property (nonatomic , assign) NSInteger              projectDuration;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) CGFloat              expectedYield;
@property (nonatomic , copy) NSString              * number;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              *name;
@property (nonatomic , assign) NSInteger              platformRateYear;
@property (nonatomic , assign) CGFloat              reservationAmount;
@property (nonatomic , assign) CGFloat              proTotalAmount;
@property (nonatomic , assign) CGFloat              actualTotalAmount;
@property (nonatomic,  copy) NSString * remainingCollectionTime;
@property (nonatomic , assign) CGFloat              addTime;
@property (nonatomic,  copy) NSString * alias;
@property (nonatomic , assign) CGFloat              collectionTime;
@property (nonatomic , assign) CGFloat              cumulativeAmount;
@property (nonatomic,  copy) NSString * imageUrl;
@property (nonatomic,  copy) NSString * introduction;

//reservationAmount（可预约金额）和proTotalAmount（总额）
@end
@interface timeModel : NSObject
@property (nonatomic ,strong) NSString *startTime;

@property (nonatomic ,strong) NSString *endTime;
@end
NS_ASSUME_NONNULL_END
