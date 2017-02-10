


#import <UIKit/UIKit.h>

@interface UILabel (TextColor)

/**
 * Set this property when switch to night version uilabel TextColor turns to this color.
 */
@property (nonatomic, strong) UIColor *nightTextColor;

/**
 *  UILabel TextColor in normal version.
 */
@property (nonatomic, strong, readonly) UIColor *normalTextColor;

@end
