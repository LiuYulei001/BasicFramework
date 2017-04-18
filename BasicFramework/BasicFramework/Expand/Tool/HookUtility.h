//
//  HookUtility.h
//  BasicFramework
//
//  Created by Rainy on 2017/4/18.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HookUtility : NSObject

/** 响应交换 */
+ (void)swizzlingInClass:(Class)clsss
        originalSelector:(SEL)originalSelector
        swizzledSelector:(SEL)swizzledSelector;

@end
