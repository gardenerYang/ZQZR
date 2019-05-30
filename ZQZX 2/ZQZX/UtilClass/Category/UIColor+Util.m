//
//  UIColor+Util.m
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "UIColor+Util.h"

@implementation UIColor (Util)
+ (UIColor *)withHexStr:(NSString *)hexStr {
    if (hexStr == nil || !(hexStr.length >= 6 && hexStr.length <= 9)) {
        return kTitleColor;
    }
    
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    //if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    //if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //NSLog(@"%f:::%f:::%f",((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f));
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1];
}
+ (UIColor *)m_red {
    return [UIColor withHexStr:@"#ff4d00"];
}
+ (UIColor *)m_Lightred {
    return [UIColor withHexStr:@"#ff6a28"];
}
+ (UIColor *)m_gray {
    return [UIColor withHexStr:@"#ebeced"];
}
+ (UIColor *)m_textGrayColor {
    return [UIColor withHexStr:@"#9a9c9d"];
}
+ (UIColor *)m_textLighGrayColor {
    return [UIColor withHexStr:@"#d6d7d8"];
}
+ (UIColor *)m_lineColor {
    return [UIColor withHexStr:@"#e9eaea"];
}
+ (UIColor *)m_blue {
    return [UIColor withHexStr:@"#3a84ed"];
}
+ (UIColor *)m_bgColor {
    return [UIColor withHexStr:@"#f5f6f7"];
}
+ (UIColor *)m_textDeepGrayColor {
    return [UIColor withHexStr:@"#646667"];
}
+ (UIColor *)m_greenColor {
    return [UIColor withHexStr:@"#5bc848"];
}


@end
