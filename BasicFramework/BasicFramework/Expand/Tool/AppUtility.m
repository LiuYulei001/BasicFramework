

#define stateLabelTextColor kRGB(90, 90, 90)

#import "AppUtility.h"
#import "MJRefresh.h"
#import "Reachability.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>

@implementation AppUtility

+ (void)checkLocationServiceAuthorization:(void(^)(BOOL authorizationAllow))checkFinishBack
{
    if ([CLLocationManager locationServicesEnabled])
    {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        switch (status) {
            case kCLAuthorizationStatusNotDetermined:
                checkFinishBack(NO);
                break;
            case kCLAuthorizationStatusRestricted:
                checkFinishBack(NO);
                break;
            case kCLAuthorizationStatusDenied:
                NSLog(@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)");
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
                checkFinishBack(YES);
                break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                checkFinishBack(YES);
                break;
                
            default:
                break;
        }
    }else
    {
        NSLog(@"此设备不支持定位服务");
    }
}
+ (void)checkAudioAuthorizationGrand:(void (^)())permissionGranted
                    withNoPermission:(void (^)())noPermission
{
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (videoAuthStatus) {
        case AVAuthorizationStatusNotDetermined:
        {
            //第一次提示用户授权
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                granted ? permissionGranted() : noPermission();
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:
        {
            //通过授权
            permissionGranted();
            break;
        }
        case AVAuthorizationStatusRestricted:
            //不能授权
            noPermission();
        case AVAuthorizationStatusDenied:{
            //提示跳转到相机设置(这里使用了blockits的弹窗方法）
            noPermission();
        }
            break;
        default:
            break;
    }
}
+ (void)checkPhotoAlbumAuthorizationGrand:(void (^)())permissionGranted
                         withNoPermission:(void (^)())noPermission
{
    PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthStatus) {
        case PHAuthorizationStatusNotDetermined:
        {
            //第一次提示用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                status == PHAuthorizationStatusAuthorized ? permissionGranted() : noPermission();
            }];
            break;
        }
        case PHAuthorizationStatusAuthorized:
        {
            //已经通过授权
            permissionGranted();
            break;
        }
        case PHAuthorizationStatusRestricted:
            //不能授权
            noPermission();
        case PHAuthorizationStatusDenied:{
            //提示跳转相册授权设置
            noPermission();
            break;
        }
        default:
            break;
            
    }
}
+ (UIViewController *)topMostController
{
    UIViewController *topController = [kWindow rootViewController];
    while ([topController presentedViewController]) topController = [topController presentedViewController];
    return topController;
}
+ (UIViewController *)currentViewController
{
    UIViewController *currentViewController = [self topMostController];
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    return currentViewController;
}
+ (void)callWithPhoneNumber:(NSString *)phoneNumber
{
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
+ (void)gradientStartColor:(UIColor *)startColor endColor:(UIColor *)endColor statusView:(UIView *)statusView
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = statusView.bounds;
    [statusView.layer addSublayer:gradientLayer];
    
    gradientLayer.locations = @[[NSNumber numberWithFloat:0], [NSNumber numberWithFloat:1.0]];
    
    gradientLayer.colors = @[(__bridge NSArray * _Nullable)(startColor.CGColor), (__bridge NSArray * _Nullable)(endColor.CGColor)];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
}

/** 获取当前网络 */
-(void)setReachability
{
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [reach startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityAction) name:kReachabilityChangedNotification object:nil];
}
-(void)reachabilityAction
{
    
    UIApplication *application = [UIApplication sharedApplication];
    
    NSArray *chlidrenArray = [[[application valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    NSInteger netType =0;
    
    for (id  child in chlidrenArray) {
        
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            
            netType = [[child valueForKeyPath:@"dataNetworkType"] integerValue];
            
        }
    }
    
    switch (netType) {
        case 0:
            
            //无网络
            
            break;
        case 1:
            
           //2G
            
            break;
        case 2:
            
            //3G
            
            break;
        case 3:
            
            //4G
            
            break;
        case 5:
            
            //WIFE
            
            break;
            
        default:
            break;
    }
    
}
/** 获取当前网络 */
+ (NSString *)getNetworkType{
    
    NSString *netconnType = @"";
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
        {
            
            netconnType = @"NoNetwork";
        }
            break;
            
        case ReachableViaWiFi:
        {
            netconnType = @"Wifi";
        }
            break;
            
        case ReachableViaWWAN:
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            
            NSString *currentStatus = info.currentRadioAccessTechnology;
            
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                
                netconnType = @"GPRS";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                
                netconnType = @"2.75G EDGE";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
                
                netconnType = @"3.5G HSDPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
                
                netconnType = @"3.5G HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                
                netconnType = @"2G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
                
                netconnType = @"HRPD";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                
                netconnType = @"4G";
            }
        }
            break;
            
        default:
            break;
    }
    
    return netconnType;
}

/** 开始下拉刷新*/
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header beginRefreshing];
}

/**判断头部是否在刷新*/
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView {
    
    BOOL flag =  scrollView.mj_header.isRefreshing;
    return flag;
}

/**判断是否尾部在刷新*/
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView {
    return  scrollView.mj_footer.isRefreshing;
}

/**提示没有更多数据的情况*/
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshingWithNoMoreData];
}

/**重置footer*/
+ (void)resetNoMoreDataForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer resetNoMoreData];
}

/**停止下拉刷新*/
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header endRefreshing];
}

/**停止上拉加载*/
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshing];
}

/** 隐藏footer*/
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView {
    // 不确定是哪个类型的footer
    scrollView.mj_footer.hidden = YES;
}

/**隐藏header*/
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView {
    scrollView.mj_header.hidden = YES;
}

/**上拉*/
+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView
                loadMoreCallBack:(RefreshAndLoadMoreHandle)loadMoreCallBackBlock {
    
    if (scrollView == nil || loadMoreCallBackBlock == nil) {
        return ;
    }
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (loadMoreCallBackBlock) {
            loadMoreCallBackBlock();
        }
    }];
    [footer setTitle:@"释放加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"Rainy正在为您加载数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了~" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = stateLabelTextColor;
    footer.stateLabel.font = ThirteenFontSize;
//    footer.automaticallyHidden = YES;
    scrollView.mj_footer = footer;
    footer.backgroundColor = kClearColor;
    
    
}

/**下拉*/
+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView
                pullRefreshCallBack:(RefreshAndLoadMoreHandle)pullRefreshCallBackBlock {
    __weak typeof(UIScrollView *)weakScrollView = scrollView;
    if (scrollView == nil || pullRefreshCallBackBlock == nil) {
        return ;
    }
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (pullRefreshCallBackBlock) {
            pullRefreshCallBackBlock();
        }
        if (weakScrollView.mj_footer.hidden == NO) {
            [weakScrollView.mj_footer resetNoMoreData];
        }
        
    }];
    
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在更新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"没有发现数据" forState:MJRefreshStateNoMoreData];
    header.stateLabel.font = ThirteenFontSize;
    header.stateLabel.textColor = stateLabelTextColor;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    scrollView.mj_header = header;
}




+(void)clearWKWebviewCaches
{
    
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0];
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    NSString *webKitFolderInCachesfs = [NSString stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
    
}













@end
