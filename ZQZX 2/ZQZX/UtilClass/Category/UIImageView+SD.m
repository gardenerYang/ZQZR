//
//  UIImageView+SD.m
//  Ninesecretary
//
//  Created by JG on 2017/10/25.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "UIImageView+SD.h"

@implementation UIImageView (SD)

- (void)sd_setImageWithString:(NSString *)strUrl {
    UIImage *wload0 = [UIImage imageNamed:@"Wload"];
    [self sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:wload0];
}
- (void)sd_setBigImageWithString:(NSString *)strUrl{
    UIImage *wload0 = [UIImage imageNamed:@"Wload"];
    [self sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:wload0];
}
- (void)sd_setFindImageWithString:(NSString *)strUrl{
    UIImage *wload0 = [UIImage imageNamed:@"Wload_find"];
    [self sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:wload0];
}
- (void)sd_setNewsImageWithString:(NSString *)strUrl{
    UIImage *wload0 = [UIImage imageNamed:@"newWload"];
    [self sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:wload0];
}
@end
