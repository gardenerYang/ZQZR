//
//  UIImageView+SD.h
//  Ninesecretary
//
//  Created by JG on 2017/10/25.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SD)

/**
 正方形图片

 @param strUrl strUrl description
 */
- (void)sd_setImageWithString:(NSString *)strUrl;
/**
 长方形

 @param strUrl strUrl description
 */
- (void)sd_setBigImageWithString:(NSString *)strUrl;
/**
 发现头部

 @param strUrl strUrl description
 */
- (void)sd_setFindImageWithString:(NSString *)strUrl;

/**
 发现

 @param strUrl strUrl description
 */
- (void)sd_setNewsImageWithString:(NSString *)strUrl;
@end
