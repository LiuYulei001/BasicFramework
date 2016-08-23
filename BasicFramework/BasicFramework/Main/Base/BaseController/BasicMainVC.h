//
//  DFYGDoFaceParentVC.h
//  CheDai
//
//  Created by Rainy on 16/7/26.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicMainVC : UIViewController

@property(nonatomic,assign)CGFloat keyboarHeight;

@property(nonatomic,assign)BOOL backBarTextIsBack;

-(void)addNotifications;
- (void)removeKeyboardNotification;

-(void)keyboardDidShow:(NSNotification *)aNotification;
- (void)keyboardWillShow:(NSNotification *)aNotification;
- (void)keyboardWillHide:(NSNotification *)aNotification;


@end
