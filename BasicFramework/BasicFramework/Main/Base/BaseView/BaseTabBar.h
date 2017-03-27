//
//  BaseTabBar.h
//  BasicFramework
//
//  Created by Rainy on 16/8/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//
/*===============================================================================
 
 自定义UITabBar；
 
 ===============================================================================*/

#import <UIKit/UIKit.h>

@class BaseTabBar;

@protocol BaseTabBarDelegate <NSObject>

@optional

- (void)tabBarMiddle_BTClick:(BaseTabBar *)tabBar;

@end


@interface BaseTabBar : UITabBar

@property (nonatomic, weak) id<BaseTabBarDelegate> myDelegate ;

@end
