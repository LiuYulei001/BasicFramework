//
//  NSTimer+Extension.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Extension)

+(void)startTimingWithTimeInterval:(NSTimeInterval)t timerAction:(void(^)(NSTimer *timer,NSTimeInterval interval))timerAction;
-(void)stopTiming;

@end
