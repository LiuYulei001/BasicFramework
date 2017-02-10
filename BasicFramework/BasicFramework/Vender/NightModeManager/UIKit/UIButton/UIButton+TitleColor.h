

#import <UIKit/UIKit.h>

@interface UIButton (TitleColor)

/**
 * Set this property when switch to night version uibutton TitleColor turns to this color.
 */
@property (nonatomic, strong) UIColor *nightTitleColor;

/**
 *  UIButton TitleColor in normal version.
 */
@property (nonatomic, strong, readonly) UIColor *normalTitleColor;

@end
