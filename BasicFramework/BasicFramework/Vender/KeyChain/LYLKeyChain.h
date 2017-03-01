//
//  LYLKeyChain.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/1.
//  Copyright © 2017年 Rainy. All rights reserved.
//

//=================================================================
//=================================================================
//   =============非沙河存储，卸载app数据依然存在=====================
//=================================================================
//=================================================================

#import <Foundation/Foundation.h>


@interface LYLKeyChain : NSObject

+ (void)saveService:(NSString *)service
           saveData:(id)saveData;

+ (id)loadService:(NSString *)service;

+ (void)deleteService:(NSString *)service;

@end
