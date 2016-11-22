//
//  BasicTouchID.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/21.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <LocalAuthentication/LocalAuthentication.h>


typedef NS_ENUM(NSUInteger, TouchID_AuthorizeState) {
    /**
     *  TouchID验证成功
     *
     *  (English Comments) Authentication Successul
     */
    TouchID_AuthorizeState_Success = 1,
    /**
     *  TouchID验证失败
     *
     *  (English Comments) Authentication Failure
     */
    TouchID_AuthorizeState_Failure,//2
    /**
     *  取消TouchID验证 (用户点击了取消)
     *
     *  (English Comments) Authentication was canceled by user (e.g. tapped Cancel button).
     */
    TouchID_AuthorizeState_ErrorUserCancel,//3
    /**
     *  在TouchID对话框中点击输入密码按钮
     *
     *  (English Comments) User tapped the fallback button
     */
    TouchID_AuthorizeState_ErrorUserFallback,//4
    /**
     *  在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
     *
     *  (English Comments) Authentication was canceled by system (e.g. another application went to foreground).
     */
    TouchID_AuthorizeState_ErrorSystemCancel,//5
    /**
     *  无法启用TouchID,设备没有设置密码
     *
     *  (English Comments) Authentication could not start, because passcode is not set on the device.
     */
    TouchID_AuthorizeState_ErrorPasscodeNotSet,//6
    /**
     *  设备没有录入TouchID,无法启用TouchID
     *
     *  (English Comments) Authentication could not start, because Touch ID has no enrolled fingers
     */
    TouchID_AuthorizeState_ErrorTouchIDNotEnrolled,//7
    /**
     *  该设备的TouchID无效
     *
     *  (English Comments) Authentication could not start, because Touch ID is not available on the device.
     */
    TouchID_AuthorizeState_ErrorTouchIDNotAvailable,//8
    /**
     *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
     *
     *  (English Comments) Authentication was not successful, because there were too many failed Touch ID attempts and Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.
     *
     */
    TouchID_AuthorizeState_ErrorTouchIDLockout,//9
    /**
     *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
     *
     *  (English Comments) Authentication was canceled by application (e.g. invalidate was called while authentication was inprogress).
     *
     */
    TouchID_AuthorizeState_ErrorAppCancel,//10
    /**
     *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
     *
     *  (English Comments) LAContext passed to this call has been previously invalidated.
     */
    TouchID_AuthorizeState_ErrorInvalidContext,//11
    /**
     *  当前设备不支持指纹识别
     *
     *  (English Comments) The current device does not support fingerprint identification
     */
    TouchID_AuthorizeState_ErrorNotSupport,//12
};

@protocol BasicTouchIDDelegate <NSObject>

@required

- (void)TouchIDAuthorizeCallBackState:(TouchID_AuthorizeState)TouchID_AuthorizeState;

@end



@interface BasicTouchID : LAContext

@property (nonatomic, weak) id<BasicTouchIDDelegate> delegate;

/**
 *  发起TouchID验证 (Initiate TouchID validation)
 *
 *  @param message 提示框需要显示的信息 默认为：输入密码 (Fallback button title. Default is "Enter Password")
 */
+ (void)startWJTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<BasicTouchIDDelegate>)delegate;

@end
