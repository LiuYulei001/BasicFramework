


#import "UITabBar+NightVersion.h"
#import "DKNightVersionManager.h"
#import "DKNightVersionUtility.h"
#import "UIView+NightVersion.h"

#import "UINavigationBar+Animation.h"

@implementation UITabBar (NightVersion)

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
        [self setBarTintColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBarTintColor : self.normalBarTintColor];
        [self setBackgroundColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
        
    }
}

@end
