

#import "UILabel+NightVersion.h"
#import "DKNightVersionManager.h"
#import "DKNightVersionUtility.h"
#import "UIView+NightVersion.h"



@implementation UILabel (NightVersion)

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        
        [UIView animateWithDuration:duration animations:^{
            [self setTextColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightTextColor : self.normalTextColor];
            [self setBackgroundColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
            
        }];
    }
}

- (void)changeColor {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        [self setTextColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightTextColor : self.normalTextColor];
        [self setBackgroundColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
        
    }
}

@end
