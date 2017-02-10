

#import "UIScrollView+BackgroundColor.h"
#import "DKNightVersionManager.h"
#import "UIView+backgroundColor.h"


@implementation UIScrollView (BackgroundColor)

- (UIColor *)defaultNightBackgroundColor {
    return [self isMemberOfClass:[UIScrollView class]] ? UIColorFromRGB(0x343434) : nil;
}

@end
