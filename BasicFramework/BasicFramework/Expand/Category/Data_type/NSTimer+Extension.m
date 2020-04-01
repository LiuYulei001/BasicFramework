//
//  NSTimer+Extension.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "NSTimer+Extension.h"
#import <objc/runtime.h>

typedef void(^timerAction)(NSTimer *timer,NSTimeInterval interval);

static const char Key;

@implementation NSTimer (Extension)

+(void)startTimingWithTimeInterval:(NSTimeInterval)t timerAction:(timerAction)timerAction
{
    if (timerAction) {
        
        objc_setAssociatedObject(self, &Key, timerAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [[self scheduledTimerWithTimeInterval:t target:self selector:@selector(timerAction:) userInfo:nil repeats:YES] fire];
    
}
+(void)timerAction:(NSTimer *)timer
{
    static NSTimeInterval interval = 0;
    interval += timer.timeInterval;
    timerAction block  = objc_getAssociatedObject(self, &Key);
    block(timer,interval);
}
-(void)stopTiming
{
    [self invalidate];
}
@end
