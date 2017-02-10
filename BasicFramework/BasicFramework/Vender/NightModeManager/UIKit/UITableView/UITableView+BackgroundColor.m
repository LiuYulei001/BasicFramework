
#import "UITableView+BackgroundColor.h"
#import "DKNightVersionManager.h"
#import "UIView+backgroundColor.h"
#import "UIScrollView+backgroundColor.h"


@implementation UITableView (BackgroundColor)

- (UIColor *)defaultNightBackgroundColor {
    return [self isMemberOfClass:[UITableView class]] ? UIColorFromRGB(0x343434) : nil;
}

@end
