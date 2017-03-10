//
//  LogManager.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/9.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogManager : NSObject

void catchExceptionHandler (NSException *exception);
#pragma mark - 获取崩溃日志
+(NSArray *)getCrashLog;
#pragma mark - 清理日志
+(void)clearCrashLog;

@end
