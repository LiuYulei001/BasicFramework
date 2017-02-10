

#import "UIBarButtonItem+NightVersion.h"
#import "DKNightVersionManager.h"
#import "DKNightVersionUtility.h"



@implementation UIBarButtonItem (NightVersion)

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        
        [UIView animateWithDuration:duration animations:^{
            [self setTintColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightTintColor : self.normalTintColor];
            
        }];
    }
}

- (void)changeColor {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        [self setTintColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightTintColor : self.normalTintColor];
        
    }
}

@end
