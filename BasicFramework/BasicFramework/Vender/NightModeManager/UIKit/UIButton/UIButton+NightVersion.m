

#import "UIButton+NightVersion.h"
#import "DKNightVersionManager.h"
#import "DKNightVersionUtility.h"
#import "UIView+NightVersion.h"



@implementation UIButton (NightVersion)

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        
        [UIView animateWithDuration:duration animations:^{
            [self setTitleColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightTitleColor : self.normalTitleColor forState:UIControlStateNormal];
            [self setBackgroundColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
            
        }];
    }
}

- (void)changeColor {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        [self setTitleColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightTitleColor : self.normalTitleColor forState:UIControlStateNormal];
        [self setBackgroundColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
        
    }
}

@end
