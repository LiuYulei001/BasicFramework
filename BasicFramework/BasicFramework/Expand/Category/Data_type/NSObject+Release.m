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

@end
