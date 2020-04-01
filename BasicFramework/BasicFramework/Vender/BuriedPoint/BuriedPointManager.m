//
//  BuriedPointManager.m
//  BasicFramework
//
//  Created by Rainy on 2017/4/28.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "BuriedPointManager.h"
#import <objc/runtime.h>
#import "UIControl+BuriedPoint.h"
#import "UIViewController+BuriedPoint.h"

@implementation BuriedPointManager
+ (void)becomeBuriedPoint {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [UIControl buriedPointForControl];
        [UIViewController buriedPointForViewController];
        
    });
}
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Class class = cls;
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
