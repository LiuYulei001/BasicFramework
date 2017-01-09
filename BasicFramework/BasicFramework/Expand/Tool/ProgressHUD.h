

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, ProgressHUDMode) {
    //菊花、文字显示
    ProgressHUDModeActivityIndicator = 0,
    //纯文字显示
    ProgressHUDModeOnlyText,
    //进度显示,通过设置progress控制进度
    ProgressHUDModeProgress
};

//同一时间只能显示一个hud
@interface ProgressHUD : NSObject

/**
 *  显示提示框，可设置隐藏时间
 *
 *  @param mode    提示框类型
 *  @param text    提示框上的文字
 *  @param delay   提示框多久隐藏
 *  @param touched 是否开启界面交互
 *  @param view    提示框的父视图，为nil时，默认加到window中
 */
+ (void)showProgressHUDWithMode:(ProgressHUDMode)mode withText:(NSString *)text afterDelay:(NSTimeInterval)delay isTouched:(BOOL)touched inView:(UIView *)view;

/**
 *  显示提示框，不能自动隐藏，需调用+(void)hideProgressHUDAfterDelay:来隐藏
 *
 *  @param mode    提示框类型
 *  @param text    提示框上的文字
 *  @param touched 是否开启界面交互
 *  @param view    提示框的父视图
 */
+ (void)showProgressHUDWithMode:(ProgressHUDMode)mode withText:(NSString *)text isTouched:(BOOL)touched inView:(UIView *)view;
/**
 *  隐藏提示框
 *
 *  @param delay 延迟隐藏时间
 */
+ (void)hideProgressHUDAfterDelay:(NSTimeInterval)delay;

/**
 *  设置进度值，只有显示类型是ProgressHUDModeProgress时，才需要调用
 *
 *  @param progress 进度值 当progress等于（0，1】意外的值时，提示框自动隐藏
 */
+ (void)setProgress:(CGFloat)progress;


// * =====================================================================================
// * 同一个view中多个subview同时使用HUD
// * =====================================================================================
/**
 *  图片上传进度
 */
+ (MBProgressHUD *)UpIMGShowProgressHUDWithText:(NSString *)text isTouched:(BOOL)touched inView:(UIView *)view progressTintColor:(UIColor *)progressTintColor;
/**
 *  纯文字提示
 */
+ (void)showProgressHUDInView:(UIView *)view withText:(NSString *)text afterDelay:(NSTimeInterval)delay;

@end
