//
//  AppDelegate+Extension.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/7.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Extension)


/**
 *  获取启动页
 *
 *  @return UIImageView
 */
-(UIImageView *)GetPortraitIMG;

#pragma mark 设置rootViewController
-(void)setMyWindowAndRootViewController;

@end
