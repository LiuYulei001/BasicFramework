//
//  LoginVC.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/8.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "LoginVC.h"
#import "UserModel.h"
#import "RequestTool.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)logining{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"1" forKey:@"name"];
    [dic setValue:@"2" forKey:@"password"];
    [[RequestTool sharedRequestTool].userRequestTool loginWithParameters:dic FinishedLogin:^(id responseObject) {
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
