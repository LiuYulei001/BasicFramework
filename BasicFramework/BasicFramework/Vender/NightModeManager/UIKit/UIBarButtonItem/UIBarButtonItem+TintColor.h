

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TintColor)

/**
 * Set this property when switch to night version uibarbuttonitem TintColor turns to this color.
 */
@property (nonatomic, strong) UIColor *nightTintColor;

/**
 *  UIBarButtonItem TintColor in normal version.
 */
@property (nonatomic, strong, readonly) UIColor *normalTintColor;

@end
