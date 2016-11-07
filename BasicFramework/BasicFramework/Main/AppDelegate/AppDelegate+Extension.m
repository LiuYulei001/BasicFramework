//
//  AppDelegate+Extension.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/7.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import "MainHelper.h"

@implementation AppDelegate (Extension)

- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [[MainHelper shareHelper]easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
}

@end
