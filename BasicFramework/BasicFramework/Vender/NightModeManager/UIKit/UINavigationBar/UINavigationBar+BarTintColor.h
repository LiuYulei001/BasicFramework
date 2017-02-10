


#import <UIKit/UIKit.h>

@interface UINavigationBar (BarTintColor)

/**
 * Set this property when switch to night version uinavigationbar BarTintColor turns to this color.
 */
@property (nonatomic, strong) UIColor *nightBarTintColor;

/**
 *  UINavigationBar BarTintColor in normal version.
 */
@property (nonatomic, strong, readonly) UIColor *normalBarTintColor;

@end
