//
//  HomeModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/26.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"
@class InveItem,MomentsItem;
NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : BaseClass
@property (nonatomic , strong) NSArray <InveItem *>              * inve;
@property (nonatomic , strong) NSArray <MomentsItem *>              * moments;
@end
@interface InveItem :NSObject
@property (nonatomic , assign) NSInteger              purchaseAmount;
@property (nonatomic , assign) NSInteger              projectDuration;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) CGFloat              expectedYield;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              platformRateYear;
@property (nonatomic , assign) CGFloat              reservationAmount;
@property (nonatomic , assign) CGFloat              proTotalAmount;
@property (nonatomic , assign) CGFloat              actualTotalAmount;
@property (nonatomic , assign) CGFloat              remainingCollectionTime;
@property (nonatomic,  copy) NSString * borrowName;
@property (nonatomic , assign) NSInteger              capital;
@property (nonatomic , assign) NSInteger              investmentNo;
@property (nonatomic , assign) NSInteger              iteration;
@property (nonatomic , assign) NSInteger              joinActivity;
@property (nonatomic , assign) NSInteger              period;
@property (nonatomic , assign) NSInteger              projectEndTime;
@property (nonatomic , assign) NSInteger              totalPeriod;
@property (nonatomic , assign) NSInteger              operation;//operation   0；不续投：1；续投


//reservationAmount（可预约金额）和proTotalAmount（总额）

@end
@interface MomentsItem :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * introduction;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * imageUrl;
@property (nonatomic , assign) NSInteger              publishTime;
@property (nonatomic , assign) NSInteger              isDisplay;
@property (nonatomic , assign) NSInteger              isTop;
@property (nonatomic , copy) NSString              * subTitle;
@property (nonatomic , copy) NSString              * source;
@property (nonatomic , assign) NSInteger              addTime;
@property (nonatomic , assign) NSInteger              updateTime;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * urlHref;

@end
NS_ASSUME_NONNULL_END
