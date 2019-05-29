//
//  GesturePwdHead.h
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#ifndef GesturePwdHead_h
#define GesturePwdHead_h
#import "GesturePwdManageService.h"

//手势密码 KEY
#define KEYCHAIN_KEY  [GesturePwdManageService keyChainWithUserID]

#define TMEPWD_KEY [GesturePwdManageService temKeyWithUserID]

#define TOUCHID_KEY  [GesturePwdManageService TouchIDWithUserID]

#endif /* GesturePwdHead_h */
