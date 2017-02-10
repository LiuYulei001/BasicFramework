


#import "UITableView+NightVersion.h"
#import "DKNightVersionManager.h"
#import "DKNightVersionUtility.h"
#import "UIView+NightVersion.h"
#import "UIScrollView+NightVersion.h"



@implementation UITableView (NightVersion)

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        
        [UIView animateWithDuration:duration animations:^{
            [self setBackgroundColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
            [self setSeparatorColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightSeparatorColor : self.normalSeparatorColor];
            
        }];
    }
}

- (void)changeColor {
    if ([DKNightVersionUtility shouldChangeColor:self]) {
        [self setBackgroundColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
        [self setSeparatorColor:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightSeparatorColor : self.normalSeparatorColor];
        
    }
}

@end
