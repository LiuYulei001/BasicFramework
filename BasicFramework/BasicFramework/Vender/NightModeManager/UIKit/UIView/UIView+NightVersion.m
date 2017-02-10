

#import "UIView+NightVersion.h"
#import "DKNightVersionManager.h"
#import "DKNightVersionUtility.h"



@implementation UIView (NightVersion)

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        
        [UIView animateWithDuration:duration animations:^{
            [self setBackgroundColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
            
        }];
    }
}

- (void)changeColor {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        [self setBackgroundColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
        
    }
}

@end
