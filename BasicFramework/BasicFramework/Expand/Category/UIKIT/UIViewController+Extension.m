//
//  UIViewController+Extension.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/8.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (void)showHUDWithType:(ProgressHUDMode)type withText:(NSString *)text afterDelay:(NSTimeInterval)delay isTouched:(BOOL)touched inView:(UIView *)view
{
    [ProgressHUD showProgressHUDWithMode:type withText:text afterDelay:delay isTouched:touched inView:view];
}
- (void)showHUDWithType:(ProgressHUDMode)type withText:(NSString *)text isTouched:(BOOL)touched inView:(UIView *)view
{
    [ProgressHUD showProgressHUDWithMode:type withText:text isTouched:touched inView:view];
}
- (void)HideHUDDelay:(NSTimeInterval)delay
{
    [ProgressHUD hideProgressHUDAfterDelay:delay];
}
- (void)setProgress:(CGFloat)progress
{
    [ProgressHUD setProgress:progress];
}

@end
