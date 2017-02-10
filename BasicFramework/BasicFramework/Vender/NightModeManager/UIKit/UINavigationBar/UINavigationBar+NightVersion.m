


#import "UINavigationBar+NightVersion.h"
#import "DKNightVersionManager.h"
#import "DKNightVersionUtility.h"
#import "UIView+NightVersion.h"

#import "UINavigationBar+Animation.h"

@implementation UINavigationBar (NightVersion)

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        [self animateNavigationBarToColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBarTintColor : self.normalBarTintColor duration:duration];
        [UIView animateWithDuration:duration animations:^{
            [self setTintColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightTintColor : self.normalTintColor];
            [self setBackgroundColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
            
        }];
    }
}

- (void)changeColor {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        [self setBarTintColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBarTintColor : self.normalBarTintColor];
        [self setTintColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightTintColor : self.normalTintColor];
        [self setBackgroundColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
        
    }
}

@end
