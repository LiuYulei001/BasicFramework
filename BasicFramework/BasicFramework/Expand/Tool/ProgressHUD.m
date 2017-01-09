

#import "ProgressHUD.h"

@interface ProgressHUD ()

@property (nonatomic, weak) MBProgressHUD *progressHUD;

@end

@implementation ProgressHUD

#pragma mark - class method
+ (instancetype)sharedHUD {
    static ProgressHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!hud) {
            hud = [ProgressHUD new];
        }
    });
    return hud;
}

+ (void)showProgressHUDWithMode:(ProgressHUDMode)mode withText:(NSString *)text afterDelay:(NSTimeInterval)delay isTouched:(BOOL)touched inView:(UIView *)view {
    [[ProgressHUD sharedHUD] showProgressHUDWithMode:mode withText:text afterDelay:delay isTouched:touched inView:view];
}

+ (void)showProgressHUDWithMode:(ProgressHUDMode)mode withText:(NSString *)text isTouched:(BOOL)touched inView:(UIView *)view {
    [[ProgressHUD sharedHUD] showProgressHUDWithMode:mode withText:text isTouched:touched inView:view];
}

+ (void)hideProgressHUDAfterDelay:(NSTimeInterval)delay {
    [[ProgressHUD sharedHUD] hideProgressHUDAfterDelay:delay];
}

+ (void)setProgress:(CGFloat)progress {
    [[ProgressHUD sharedHUD] setProgress:progress];
}


#pragma mark - instance && private method
- (void)showProgressHUDWithMode:(ProgressHUDMode)mode withText:(NSString *)text afterDelay:(NSTimeInterval)delay isTouched:(BOOL)touched inView:(UIView *)view {
    [self showProgressHUDWithMode:mode withText:text isTouched:touched inView:view];
    [self.progressHUD hide:YES afterDelay:delay];
}

- (void)showProgressHUDWithMode:(ProgressHUDMode)mode withText:(NSString *)text isTouched:(BOOL)touched inView:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    if (self.progressHUD) {
        [self hideProgressHUDAfterDelay:0];
    }
    self.progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.progressHUD.userInteractionEnabled = !touched;
    if (!touched) {
        self.progressHUD.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1f];
    }
    self.progressHUD.labelText = text;
    self.progressHUD.removeFromSuperViewOnHide = YES;
    switch (mode) {
        case ProgressHUDModeActivityIndicator:
            self.progressHUD.mode = MBProgressHUDModeIndeterminate;
            break;
        case ProgressHUDModeOnlyText:
            self.progressHUD.mode = MBProgressHUDModeText;
            break;
        case ProgressHUDModeProgress:
            self.progressHUD.mode = MBProgressHUDModeAnnularDeterminate;
            break;
        default:
            break;
    }
}

- (void)hideProgressHUDAfterDelay:(NSTimeInterval)delay {
    [self.progressHUD hide:YES afterDelay:delay];
    self.progressHUD = nil;
}

- (void)setProgress:(CGFloat)progress {
    self.progressHUD.progress = progress;
    if (progress >= 1 || progress < 0) {
        [self.progressHUD hide:YES];
    }
}


+ (void)showProgressHUDInView:(UIView *)view withText:(NSString *)text afterDelay:(NSTimeInterval)delay
{
    [[ProgressHUD sharedHUD]showProgressHUDInView:view withText:text afterDelay:delay];
}
+ (MBProgressHUD *)UpIMGShowProgressHUDWithText:(NSString *)text isTouched:(BOOL)touched inView:(UIView *)view progressTintColor:(UIColor *)progressTintColor
{
    return [[ProgressHUD sharedHUD]UpIMGShowProgressHUDWithText:text isTouched:touched inView:view progressTintColor:progressTintColor];
}
- (MBProgressHUD *)UpIMGShowProgressHUDWithText:(NSString *)text isTouched:(BOOL)touched inView:(UIView *)view progressTintColor:(UIColor *)progressTintColor {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progressHUD.userInteractionEnabled = !touched;
    if (!touched) {
        progressHUD.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1f];
    }
    progressHUD.labelText = text;
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.mode = MBProgressHUDModeCustomView;
    //MBRoundProgressView
    progressHUD.opacity = 0;
    MBRoundProgressView *ProgressView = [[MBRoundProgressView alloc]init];
    ProgressView.progressTintColor = progressTintColor;
    ProgressView.backgroundTintColor = WhiteColor;
    progressHUD.customView = ProgressView;
    ProgressView.annular = YES;
    return progressHUD;
}
- (void)showProgressHUDInView:(UIView *)view withText:(NSString *)text afterDelay:(NSTimeInterval)delay{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progressHUD.userInteractionEnabled = NO;
    progressHUD.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1f];
    progressHUD.labelText = text;
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.mode = MBProgressHUDModeText;
    [progressHUD hide:YES afterDelay:delay];
}



@end
