


#import <UIKit/UIKit.h>

@interface UITableView (SeparatorColor)

/**
 * Set this property when switch to night version uitableview SeparatorColor turns to this color.
 */
@property (nonatomic, strong) UIColor *nightSeparatorColor;

/**
 *  UITableView SeparatorColor in normal version.
 */
@property (nonatomic, strong, readonly) UIColor *normalSeparatorColor;

@end
