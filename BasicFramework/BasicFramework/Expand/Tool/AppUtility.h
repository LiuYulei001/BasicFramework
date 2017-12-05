

#import <Foundation/Foundation.h>

typedef void(^RefreshAndLoadMoreHandle)(void);

@interface AppUtility : NSObject
/** 检测定位权限 */
+ (void)checkLocationServiceAuthorization:(void(^)(BOOL authorizationAllow))checkFinishBack;
/** 检测访问相册的权限 */
+ (void)checkPhotoAlbumAuthorizationGrand:(void (^)())permissionGranted
                         withNoPermission:(void (^)())noPermission;
/** 检测访问相机、麦克风的权限 */
+ (void)checkAudioAuthorizationGrand:(void (^)())permissionGranted
                    withNoPermission:(void (^)())noPermission;
/** get currentViewController */
+ (UIViewController *)currentViewController;
/** call */
+ (void)callWithPhoneNumber:(NSString *)phoneNumber;
/** status gradient color */
+ (void)gradientStartColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                statusView:(UIView *)statusView;
/** 获取当前网络 */
+ (NSString *)getNetworkType;
/** 清除WKWebview缓存 */
+(void)clearWKWebviewCaches;
/** 开始下拉刷新 */
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView;

/** 判断头部是否在刷新 */
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView;

/** 判断是否尾部在刷新 */
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView;

/** 提示没有更多数据的情况 */
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView;

/**   重置footer */
+ (void)resetNoMoreDataForScrollView:(UIScrollView *)scrollView;

/**  停止下拉刷新 */
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView;

/**  停止上拉加载 */
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView;

/**  隐藏footer */
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView;

/** 隐藏header */
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView;

/** 下拉刷新 */
+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView
                loadMoreCallBack:(RefreshAndLoadMoreHandle)loadMoreCallBackBlock;

/** 上拉加载 */
+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView
                pullRefreshCallBack:(RefreshAndLoadMoreHandle)pullRefreshCallBackBlock;




@end
