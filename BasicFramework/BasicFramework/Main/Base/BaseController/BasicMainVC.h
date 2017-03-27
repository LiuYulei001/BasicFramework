//
//  BasicMainVC.h
//  BasicFramework
//
//  Created by Rainy on 2017/1/17.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicMainVC : UIViewController

@property(nonatomic,assign)CGFloat keyboarHeight;

-(void)addNotifications;
- (void)removeKeyboardNotification;

-(void)keyboardDidShow:(NSNotification *)aNotification;
- (void)keyboardWillShow:(NSNotification *)aNotification;
- (void)keyboardWillHide:(NSNotification *)aNotification;


@end
