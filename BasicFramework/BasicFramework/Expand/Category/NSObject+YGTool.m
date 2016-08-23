//
//  NSObject+YGTool.m
//  PreheatDemo
//
//  Created by victor on 16/7/15.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

#import "NSObject+YGTool.h"

@implementation NSObject (YGTool)
+ (UIViewController*)viewControllerWithviewObj:(UIView *)viewObj {
    
    for (UIView* next = [viewObj superview]; next; next =
         next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
