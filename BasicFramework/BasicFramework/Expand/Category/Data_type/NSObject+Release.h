//
//  NSObject+Release.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/10.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^timingChildThreadsBlock)(NSObject *obj,NSTimeInterval TimeIntervalNow);

@interface NSObject (Release)


#pragma mark - 监听对象释放时事件
- (void)addDeallocBlock:(void(^)(void))block;

//倒计时器停止时间timeout，多久走一次TimeInterval，timingChildThreadsBlock子线程操作
-(void)startTimingWithTimeOut:(NSTimeInterval)timeout TimeInterval:(NSTimeInterval)TimeInterval timingChildThreadsBlock:(timingChildThreadsBlock)timingChildThreadsBlock;
//倒计时停止
-(void)stopCountDown;
//回到主线程
-(void)dispatch_get_main_queue:(void(^)())main_queue;

@end
