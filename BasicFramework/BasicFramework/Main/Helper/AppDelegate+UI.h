//
//  AppDelegate+UI.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/7.
//  Copyright © 2016年 Rainy. All rights reserved.
//
/*===============================================================================
 
 AppDelegate的UI方面的维护：启动页、广告页等；
 
 ===============================================================================*/

#import "AppDelegate.h"

@interface AppDelegate (UI)


/**
 *  获取启动页
 *
 *  @return UIImageView
 */
-(UIImageView *)GetPortraitIMG;

#pragma mark 设置rootViewController
-(void)setMyWindowAndRootViewController;

@end
