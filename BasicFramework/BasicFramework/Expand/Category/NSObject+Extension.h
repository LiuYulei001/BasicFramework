//
//  NSObject+Extension.h
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

#pragma mark - Get a view of the parent ViewController
+ (UIViewController*)viewControllerWithviewObj:(UIView *)viewObj;

@end
