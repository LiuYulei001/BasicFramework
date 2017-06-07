//
//  GlobalConstants.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/10.
//  Copyright © 2016年 Rainy. All rights reserved.
//


#pragma mark - 全局常量


extern NSString * const _NotificationNameForAppDelegateBackOff;


/**
 *  传入设计师提供的宽度获得适配屏幕的真实宽度（我们设计师提供的图片的标准是iPhone 6(@2x) : 750 x 1334）
 *
 *  @param designWidth 设计师提供的宽度
 *
 *  @return 适配屏幕的真实宽度
 */
static inline CGFloat xmc_realWidth(CGFloat designWidth)
{
    return  (designWidth / 750.0) * ([UIScreen mainScreen].bounds.size.width);
}

/**
 *  传入设计师提供的高度获得适配屏幕的真实高度（我们设计师提供的图片的标准是iPhone 6(@2x) : 750 x 1334）
 *
 *  @param designHeight 设计师提供的高度
 *
 *  @return 适配屏幕的真实高度
 */
static inline CGFloat xmc_realHeight(CGFloat designHeight)
{
    return  (designHeight / 1334.0) * ([UIScreen mainScreen].bounds.size.height);
}


