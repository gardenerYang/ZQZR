//
//  AppUserProfile.m
//  ZQZX
//
//  Created by 中企 on 2018/10/18.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "AppUserProfile.h"
#import "NSDictionary+ValueAccess.h"
AppUserProfile *g_userProfile = nil;
@interface AppUserProfile()

+(NSString*)localFilePathName;

@end
@implementation AppUserProfile
+(NSString*)localFilePathName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    return [docDir stringByAppendingPathComponent:@"user.plist"];
}

+ (AppUserProfile*)sharedInstance
{
    if( g_userProfile == nil )
        g_userProfile = [[AppUserProfile alloc] init];
    
    return g_userProfile;
}

- (instancetype)init
{
    if( self = [super init] )
    {
        [self load];
    }
    return self;
}

-(void)cleanUp
{
    _userId = @"";
    //    _userName = @"";
    _oauthToken = @"";
    _tokenExpiredTime = nil;
    _phoneNumber = @"";
    _emailAddress = @"";
    _idNo = @"";
    _realName = @"";

    [self.customAttributes removeAllObjects];
    [self save];
}



- (BOOL)save
{
    if (self.userId != 0) {
        [_customAttributes setObject:_userId forKey:@"userId"];
    }
    if (self.tokenExpiredTime != nil) {
        [_customAttributes setObject:_tokenExpiredTime forKey:@"expiresIn"];
    }
    if (self.oauthToken != nil) {
        [_customAttributes setObject:_oauthToken forKey:@"oauthToken"];
    }
    if (self.refresh_token != nil) {
        [_customAttributes setObject:_refresh_token forKey:@"refreshToken"];
    }
    if (self.realName != nil) {
        [_customAttributes setObject:_realName forKey:@"realName"];
    }
    if (self.idNo != nil) {
        [_customAttributes setObject:_idNo forKey:@"idNo"];
    }
    if (self.username != nil) {
        [_customAttributes setObject:_username forKey:@"username"];
    }
    return [_customAttributes writeToFile:[AppUserProfile localFilePathName] atomically:YES];
}




- (BOOL)load
{
    self.customAttributes = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUserProfile localFilePathName]];
    if( _customAttributes == nil )
    {
        _customAttributes = [NSMutableDictionary dictionary];
        return NO;
    }
    self.refresh_token = [_customAttributes stringValueForKey:@"refreshToken"];
    self.userId = [_customAttributes stringValueForKey:@"userId"];
    self.oauthToken = [_customAttributes stringValueForKey:@"oauthToken"];
    self.idNo = [_customAttributes stringValueForKey:@"idNo"];
    self.realName = [_customAttributes stringValueForKey:@"realName"];

    //    self.userId = [[_customAttributes stringValueForKey:@"userId"] integerValue];
    
    return YES;
}

-(void)updateTokenExpiredTime:(NSTimeInterval)life
{
    _tokenExpiredTime = [NSDate dateWithTimeIntervalSinceNow:life];
}

-(BOOL)isLogon
{
    return [AppUserProfile sharedInstance].userId.length > 0;
}

-(BOOL)saveUserInfoWithModel:(LoginModel *)model
{
    BOOL relsut;
//    [AppUserProfile sharedInstance].tokenExpiredTime = model.expiresIn;
    [AppUserProfile sharedInstance].oauthToken = model.token;
    //    [RdAppUserProfile sharedInstance].refresh_token = model.refreshToken;
    [AppUserProfile sharedInstance].userId = [NSString stringWithFormat:@"%ld",(long)model.id] ;
        [AppUserProfile sharedInstance].realName = model.realName;
    [AppUserProfile sharedInstance].idNo = model.idNo;

    relsut = [[AppUserProfile sharedInstance] save];
    return relsut;
}
-(BOOL)saveidNo:(NSString *)idNo{
    if (idNo.length == 0) {
        return NO;
    }else{
        [_customAttributes setObject:idNo forKey:@"idNo"];
        self.idNo = idNo;
        return  [[AppUserProfile sharedInstance] save];
    }
}
-(BOOL)saveidrealName:(NSString *)realName{
    if (realName.length == 0) {
        return NO;
    }else{
        self.realName = realName;
        [_customAttributes setObject:realName forKey:@"realName"];
       return [[AppUserProfile sharedInstance] save];
    }
}
@end
