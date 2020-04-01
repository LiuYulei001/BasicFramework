//
//  BuriedPointManager.h
//  BasicFramework
//
//  Created by Rainy on 2017/4/28.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuriedPointManager : NSObject

/** 开始埋点 */
+ (void)becomeBuriedPoint;
/** 响应交换 */
+ (void)swizzlingInClass:(Class)clsss
        originalSelector:(SEL)originalSelector
        swizzledSelector:(SEL)swizzledSelector;

@end
