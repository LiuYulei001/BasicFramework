
#import <UIKit/UIKit.h>

@interface UIView (BackgroundColor)

/**
 * Set this property when switch to night version uiview BackgroundColor turns to this color.
 */
@property (nonatomic, strong) UIColor *nightBackgroundColor;

/**
 *  UIView BackgroundColor in normal version.
 */
@property (nonatomic, strong, readonly) UIColor *normalBackgroundColor;

@end
