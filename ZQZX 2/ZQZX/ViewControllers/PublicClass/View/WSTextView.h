//
//  WSTextView.h
//  OFFICE
//
//  Created by 伟森 张豪 on 14-4-23.
//  Copyright (c) 2014年 WEISEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSTextView : UITextView
{
    UILabel *_placeHolderLabel;
}
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;
@property (nonatomic, retain) UILabel *_placeHolderLabel;
@end