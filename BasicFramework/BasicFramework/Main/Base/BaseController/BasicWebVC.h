//
//  BasicWebVC.h
//  CashBack
//
//  Created by Rainy on 2017/4/11.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "BasicMainVC.h"

@interface BasicWebVC : BasicMainVC

@property(nonatomic,assign)CGRect viewFrame;

- (void)reloadForGetWebView:(NSString *)htmlStr;
- (void)reloadForPostWebView:(NSString *)htmlStr parameters:(NSDictionary *)parameters;

@end
