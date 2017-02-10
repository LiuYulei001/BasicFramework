


#import <UIKit/UIKit.h>

@interface UITabBar (BarTintColor)

/**
 * Set this property when switch to night version uitabbar BarTintColor turns to this color.
 */
@property (nonatomic, strong) UIColor *nightBarTintColor;

/**
 *  UITabBar BarTintColor in normal version.
 */
@property (nonatomic, strong, readonly) UIColor *normalBarTintColor;

@end
