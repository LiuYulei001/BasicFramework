//
//  NSObject+Release.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/10.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "NSObject+Release.h"
#import <objc/runtime.h>

@interface Release : NSObject


@property (nonatomic, copy) void(^deallocBlock)(void);


@end

@implementation Release


- (void)dealloc {
    
    if (self.deallocBlock) {
        self.deallocBlock();
    }
}

@end



@implementation NSObject (Release)

- (void)addDeallocBlock:(void(^)(void))block {
    @synchronized (self) {
        static NSString *kAssociatedKey = nil;
        NSMutableArray *parasiteList = objc_getAssociatedObject(self, &kAssociatedKey);
        if (!parasiteList) {
            parasiteList = [NSMutableArray new];
            objc_setAssociatedObject(self, &kAssociatedKey, parasiteList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        Release *release = [Release new];
        release.deallocBlock = block;
        [parasiteList addObject: release];
    }
}

static char const dispatch_source_timer_;

-(void)startTimingWithTimeOut:(NSTimeInterval)timeout TimeInterval:(NSTimeInterval)TimeInterval timingChildThreadsBlock:(timingChildThreadsBlock)timingChildThreadsBlock
{
    __block NSTimeInterval timeOut = timeout; //The countdown time
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = objc_getAssociatedObject(self, &dispatch_source_timer_);
    if (!_timer) {
        
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        objc_setAssociatedObject(self, &dispatch_source_timer_, _timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),TimeInterval*NSEC_PER_SEC, 0); //To perform a second
    
    dispatch_source_set_event_handler(_timer, ^{
        
        timeOut -= TimeInterval;
        
        if(timeOut < 0)
        { //it is time to
            dispatch_source_cancel(_timer);
        }else{
            
            
            timingChildThreadsBlock(self,timeOut);
            
            
        }
        
        
        
        
    });
    dispatch_resume(_timer);
    
    
}
-(void)stopCountDown{
    
    dispatch_source_t _timer = objc_getAssociatedObject(self, &dispatch_source_timer_);
    if (_timer) {
        
        dispatch_source_cancel(_timer);
    }
}
-(void)dispatch_get_main_queue:(void(^)())main_queue{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        main_queue();
    });
    
}
-(dispatch_source_t)dispatch_source_tmier
{
    return objc_getAssociatedObject(self, &dispatch_source_timer_);
}
-(void)setDispatch_source_tmier:(dispatch_source_t)dispatch_source_tmier
{
    objc_setAssociatedObject(self, &dispatch_source_timer_, dispatch_source_tmier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
