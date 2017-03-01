//
//  LYLKeyChainForPassWord.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/1.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "LYLKeyChain.h"

@interface LYLKeyChainForPassWord : LYLKeyChain
/*
 ********** 存储密码 **********
 *
 * @param   PW       密码
 * @param   PWkey    密码key
 * @param   service  数据key
 *
 */
+ (void)LYLkeyChainSavePW:(NSString *)PW
                 forPWkey:(NSString *)PWkey
                  service:(NSString *)service;
/*
 ********** 获取对应密码 **********
 *
 * @param   PWkey    密码key
 * @param   service  数据key
 *
 * @return  PW密码
 *
 */
+ (NSString *)LYLkeyChainLoadOfPWkey:(NSString *)PWkey
                             service:(NSString *)service;
/*
 ********** 删除密码 **********
 *
 * @param   service    key
 *
 */
+ (void)LYLkeyChainDelete:(NSString *)service;

@end
