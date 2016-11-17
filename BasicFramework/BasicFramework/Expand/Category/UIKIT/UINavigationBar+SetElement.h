//
//  UINavigationBar+SetElement.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/17.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (SetElement)
/**
 *  通过运行时设置背景颜色
 */
- (void)ad_setBackgroundColor:(UIColor *)backgroundColor;

/**
 *  设置导航栏上元素的透明度
 */
- (void)setElementsAlpha:(CGFloat)alpha;

/**
 *  设置导航栏的偏移量 Y轴
 */
- (void)setTranslationY:(CGFloat)translationY;

/**
 *  恢复默认设置
 */
- (void)reset;

// 显示导航栏下面的分割线
- (void)showNavigationBarBottomLineView;

// 隐藏导航栏下面的分割线
- (void)hiddenNavigationBarBottomLineView;
@end
