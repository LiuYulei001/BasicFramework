

#import "UITableViewCell+BackgroundColor.h"
#import "DKNightVersionManager.h"
#import "UIView+backgroundColor.h"


@implementation UITableViewCell (BackgroundColor)

- (UIColor *)defaultNightBackgroundColor {
    return [self isMemberOfClass:[UITableViewCell class]] ? UIColorFromRGB(0x343434) : nil;
}

@end
