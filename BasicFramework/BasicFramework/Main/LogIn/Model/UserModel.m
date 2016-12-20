//
//  UserModel.m
//  BasicFramework
//
//  Created by Rainy on 2016/12/19.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UserModel.h"
#import "LoginConstants.h"

@implementation UserModel

+(void)loginWithName:(NSString *)name PW:(NSString *)PW FinishedLogin:(void(^)(UserModel *model))FinishedLogin
{
    
    
    if ([NSString isNULL:name]) {
        
        [ProgressHUD showProgressHUDWithMode:1 withText:NoNameString afterDelay:1 isTouched:NO inView:kWindow];
        return;
    }
    if ([NSString isNULL:PW]) {
        
        [ProgressHUD showProgressHUDWithMode:1 withText:NoPWString afterDelay:1 isTouched:NO inView:kWindow];
        return;
    }
    
    [ProgressHUD showProgressHUDWithMode:0 withText:LoginingString isTouched:NO inView:kWindow];
    NSMutableDictionary *parameters_dic = [NSMutableDictionary dictionary];
    [parameters_dic setValue:name forKey:LoginNameParameter_KEY];
    [parameters_dic setValue:PW forKey:LoginPWParameter_KEY];
    
    [[NetWorkManager sharedInstance] requestDataForPOSTWithURL:_Login_URL  parameters:parameters_dic Controller:nil success:^(id responseObject) {
        
        
        if ([responseObject[responseObjectSucceed_KEY] intValue] == 1) {
            
            NSString *UserID = responseObject[responseObjectUserID_KEY];
            
            [FileCacheManager saveInMyLocalStoreForValue:UserID atKey:KEY_USER_ID];
            
            UserModel *model = [[UserModel alloc]initWithDictionary:responseObject error:nil];
            [ProgressHUD hideProgressHUDAfterDelay:0];
            
            FinishedLogin(model);
            
        }else{
            [ProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:[NSString stringWithFormat:@"%@",responseObject[responseObjectErrorMessage_KEY]] afterDelay:1.5 isTouched:YES inView:kWindow];
        }
    } failure:^(NSError *error) {
        
        [ProgressHUD hideProgressHUDAfterDelay:0];
        [ProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:!error ? Request_NoNetwork : LoginErrorString afterDelay:1.5 isTouched:YES inView:kWindow];
    }];
    
    
    
}

@end
