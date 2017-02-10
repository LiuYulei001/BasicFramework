

#import <UIKit/UIKit.h>

@interface UINavigationBar (TintColor)

/**
 * Set this property when switch to night version uinavigationbar TintColor turns to this color.
 */
@property (nonatomic, strong) UIColor *nightTintColor;

/**
 *  UINavigationBar TintColor in normal version.
 */
@property (nonatomic, strong, readonly) UIColor *normalTintColor;

@end
