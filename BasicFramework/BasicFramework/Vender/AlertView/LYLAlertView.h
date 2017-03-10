//
//  LYLAlertView.h
//  LYLAlertView
//
//  Created by Rainy on 2017/2/8.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLBouncing.h"
#import "LYLConstants.h"

@class LYLAlertView;

typedef void (^dismissAlertWithButton)(LYLAlertView *alertView, UIButton *currentBT);

@protocol LYLAlertViewDelegate;

@interface LYLAlertView : UIView

@property (nonatomic, assign) float cornerRadius;
@property (nonatomic, assign) bool isDisplayed;
@property (nonatomic, assign) AnimationType animationType;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * textLabel;
@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, weak) id<LYLAlertViewDelegate> delegate;
@property (nonatomic, copy) dismissAlertWithButton completionBlock;


- (id) initDropAlertWithTitle:(NSString*)title
                      andText:(NSString*)text
              andCancelButton:(BOOL)hasCancelButton
                 forAlertType:(AlertType)type;

- (id) initDropAlertWithTitle:(NSString*)title
                      andText:(NSString*)text
              andCancelButton:(BOOL)hasCancelButton
                 forAlertType:(AlertType)type
                     andColor:(UIColor*)color;

- (id) initFadeAlertWithTitle:(NSString*)title
                      andText:(NSString*)text
              andCancelButton:(BOOL)hasCancelButton
                 forAlertType:(AlertType)type;

- (id) initFadeAlertWithTitle:(NSString*)title
                      andText:(NSString*)text
              andCancelButton:(BOOL)hasCancelButton
                 forAlertType:(AlertType)type
                     andColor:(UIColor*)color;

// init with completion block

- (id) initDropAlertWithTitle:(NSString*)title
                      andText:(NSString*)text
              andCancelButton:(BOOL)hasCancelButton
                 forAlertType:(AlertType)type
        withCompletionHandler:(dismissAlertWithButton)completionHandler;

- (id) initDropAlertWithTitle:(NSString*)title
                      andText:(NSString*)text
              andCancelButton:(BOOL)hasCancelButton
                 forAlertType:(AlertType)type
                     andColor:(UIColor*)color
        withCompletionHandler:(dismissAlertWithButton)completionHandler;

- (id) initFadeAlertWithTitle:(NSString*)title
                      andText:(NSString*)text
              andCancelButton:(BOOL)hasCancelButton
                 forAlertType:(AlertType)type
        withCompletionHandler:(dismissAlertWithButton)completionHandler;

- (id) initFadeAlertWithTitle:(NSString*)title
                      andText:(NSString*)text
              andCancelButton:(BOOL)hasCancelButton
                 forAlertType:(AlertType)type
                     andColor:(UIColor*)color
        withCompletionHandler:(dismissAlertWithButton)completionHandler;

- (void) setCornerRadius:(float)cornerRadius;
- (void) setTitleText:(NSString*) string;
- (void) setMessageText:(NSString*) string;
- (void) show;
- (void) dismissAlertView;
- (void) handleButtonTouched:(id) sender;


@end

@protocol LYLAlertViewDelegate <NSObject>

@optional
-(void) alertView:(LYLAlertView *)alertView didDismissWithButton:(UIButton *)button;
-(void) alertViewWillShow:(LYLAlertView *)alertView;
-(void) alertViewDidShow:(LYLAlertView *)alertView;
-(void) alertViewWillDismiss:(LYLAlertView *)alertView;
-(void) alertViewDidDismiss:(LYLAlertView *)alertView;

@end
