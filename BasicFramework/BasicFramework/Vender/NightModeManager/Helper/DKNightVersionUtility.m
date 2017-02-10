

#import "DKNightVersionUtility.h"
#import "DKNightVersionManager.h"

@implementation DKNightVersionUtility

+ (BOOL)shouldChangeColor:(id)object {
    __block BOOL shouldChangeColor = NO;
    [[DKNightVersionManager respondClasseses] enumerateObjectsUsingBlock:^(NSString *klassString, BOOL *stop) {
        Class klass = NSClassFromString(klassString);
        if ([object isMemberOfClass:klass]) {
            shouldChangeColor = YES;
            *stop = YES;
        }
    }];
    return shouldChangeColor;
}


@end
