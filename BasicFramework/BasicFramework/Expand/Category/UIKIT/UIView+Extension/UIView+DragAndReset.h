//
//  UIView+DragAndReset.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/15.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DragAndReset)

/**
 *  Make view draggable.
 *
 *  @param view    Animator reference view, usually is super view.
 *  @param damping Value from 0.0 to 1.0. 0.0 is the least oscillation. default is 0.4.
 */
- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping;
- (void)makeDraggable;

/**
 *  Disable view draggable.
 */
- (void)removeDraggable;
/**
 *  让某一个视图抖动
 *
 *  @param viewToShake 需要抖动的视图
 */
- (void)viewToShake;

@end
