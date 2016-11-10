//
//  UIViewController+Extension.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/8.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)


/**
 *  显示提示框，可设置隐藏时间
 *
 *  @param mode    提示框类型
 *  @param text    提示框上的文字
 *  @param delay   提示框多久隐藏
 *  @param touched 是否开启界面交互
 *  @param view    提示框的父视图，为nil时，默认加到window中
 */
- (void)showHUDWithType:(ProgressHUDMode)type withText:(NSString *)text afterDelay:(NSTimeInterval)delay isTouched:(BOOL)touched inView:(UIView *)view;

/**
 *  显示提示框，不能自动隐藏，需调用+(void)hideProgressHUDAfterDelay:来隐藏
 *
 *  @param mode    提示框类型
 *  @param text    提示框上的文字
 *  @param touched 是否开启界面交互
 *  @param view    提示框的父视图
 */
- (void)showHUDWithType:(ProgressHUDMode)type withText:(NSString *)text isTouched:(BOOL)touched inView:(UIView *)view;
/**
 *  隐藏提示框
 *
 *  @param delay 延迟隐藏时间
 */
- (void)HideHUDDelay:(NSTimeInterval)delay;

/**
 *  设置进度值，只有显示类型是ProgressHUDModeProgress时，才需要调用
 *
 *  @param progress 进度值 当progress等于（0，1】意外的值时，提示框自动隐藏
 */
- (void)setProgress:(CGFloat)progress;


@end
