//
//  BasicTouchID.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/21.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "BasicTouchID.h"
#import <objc/runtime.h>

static char const touchIDkey;

@implementation BasicTouchID
+ (void)startWJTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<BasicTouchIDDelegate>)delegate {
    
    LAContext *context = [[LAContext alloc]init];
    
    context.localizedFallbackTitle = [NSString isNULL:fallbackTitle] ? [NSString LanguageInternationalizationCH:@"输入密码" EN:@"Enter the password"] : fallbackTitle;
    message = [NSString isNULL:message] ? [NSString LanguageInternationalizationCH:@"通过Home键验证已有指纹" EN:@"Existing fingerprint are verified through the Home button"] : message;
    NSError *error = nil;
    
    BasicTouchID *touchID = objc_getAssociatedObject(self, &touchIDkey);
    if (!touchID) {
        
        touchID = [[BasicTouchID alloc]init];
        objc_setAssociatedObject(self, &touchIDkey, touchID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    touchID.delegate = delegate;
    
    __block TouchID_AuthorizeState _AuthorizeState;
    
    NSAssert(touchID.delegate != nil, [NSString LanguageInternationalizationCH:@"BasicTouchIDDelegate 不能为空" EN:@"BasicTouchIDDelegate must be non-nil"]);
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                
                _AuthorizeState = TouchID_AuthorizeState_Success;
                if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
                    }];
                    
                }
                
            } else if (error) {
                
                switch (error.code) {
                        
                    case LAErrorAuthenticationFailed: {
                        
                        _AuthorizeState = TouchID_AuthorizeState_Failure;
                        if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
                            }];
                            
                        }
                    }
                        break;
                        
                    case LAErrorUserCancel: {
                        
                        _AuthorizeState = TouchID_AuthorizeState_ErrorUserCancel;
                        if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
                            }];
                            
                        }
                    }
                        break;
                        
                    case LAErrorUserFallback: {
                        
                        _AuthorizeState = TouchID_AuthorizeState_ErrorUserFallback;
                        if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
                            }];
                            
                        }
                    }
                        break;
                        
                    case LAErrorSystemCancel:{
                        
                        _AuthorizeState = TouchID_AuthorizeState_ErrorSystemCancel;
                        if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
                            }];
                            
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDNotEnrolled: {
                        
                        _AuthorizeState = TouchID_AuthorizeState_ErrorTouchIDNotEnrolled;
                        if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
                            }];
                            
                        }
                    }
                        break;
                        
                    case LAErrorPasscodeNotSet: {
                        
                        _AuthorizeState = TouchID_AuthorizeState_ErrorPasscodeNotSet;
                        if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
                            }];
                            
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDNotAvailable: {
                        
                        _AuthorizeState = TouchID_AuthorizeState_ErrorTouchIDNotAvailable;
                        if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
                            }];
                            
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDLockout: {
                        
                        _AuthorizeState = TouchID_AuthorizeState_ErrorTouchIDLockout;
                        if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
                            }];
                            
                        }
                    }
                        break;
                        
                    case LAErrorAppCancel:  {
                        
                        _AuthorizeState = TouchID_AuthorizeState_ErrorAppCancel;
                        if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
                            }];
                            
                        }
                    }
                        break;
                        
                    case LAErrorInvalidContext: {
                        
                        _AuthorizeState = TouchID_AuthorizeState_ErrorInvalidContext;
                        if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
                            }];
                            
                        }
                    }
                        break;
                }
            }
        }];
        
    } else {
        
        _AuthorizeState = TouchID_AuthorizeState_ErrorNotSupport;
        if ([touchID.delegate respondsToSelector:@selector(TouchIDAuthorizeCallBackState:)]) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [touchID.delegate TouchIDAuthorizeCallBackState:_AuthorizeState];
            }];
            
        }
    }
    
    
    
    
}

@end
