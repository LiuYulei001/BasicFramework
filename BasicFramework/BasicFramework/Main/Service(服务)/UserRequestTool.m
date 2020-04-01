//
//  UserRequestTool.m
//  BasicFramework
//
//  Created by Rainy on 2017/10/30.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "UserRequestTool.h"
#import "NetWorkManagerTwo.h"

@implementation UserRequestTool
-(void)loginWithParameters:(NSDictionary *)parameters
             FinishedLogin:(void(^)(id responseObject))FinishedLogin
{
    [NetWorkManagerTwo requestDataWithURL:_Login_URL
                              requestType:POST
                               parameters:parameters
                           uploadProgress:nil
                                  success:^(id responseObject,id data)
     {

         FinishedLogin(responseObject);
         
     } failure:^(NSError *error) {
         
     }];
    
    
}
@end
