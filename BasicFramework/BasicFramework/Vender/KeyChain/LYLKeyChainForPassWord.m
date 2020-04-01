//
//  LYLKeyChainForPassWord.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/1.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "LYLKeyChainForPassWord.h"

@implementation LYLKeyChainForPassWord


+ (void)LYLkeyChainSavePW:(NSString *)PW forPWkey:(NSString *)PWkey service:(NSString *)service{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:PW forKey:PWkey];
    [self saveService:service saveData:tempDic];
}

+ (NSString *)LYLkeyChainLoadOfPWkey:(NSString *)PWkey service:(NSString *)service{
    NSMutableDictionary *tempDic = (NSMutableDictionary *)[self loadService:service];
    return [tempDic objectForKey:PWkey];
}

+ (void)LYLkeyChainDelete:(NSString *)service{
    [self deleteService:service];
}

@end
