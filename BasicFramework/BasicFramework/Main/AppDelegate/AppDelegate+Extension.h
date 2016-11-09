//
//  AppDelegate+Extension.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/7.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Extension)

- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/**
 *  获取启动页
 *
 *  @return UIImageView
 */
-(UIImageView *)GetPortraitIMG;

@end
