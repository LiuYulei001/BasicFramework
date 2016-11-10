

#import <Foundation/Foundation.h>
@interface AppSingle : NSObject

+(instancetype)Shared;
/**
 *  手机唯一标示
 */
-(NSString *)getUUID;
/**
 *  上拉加载
 */
-(void)addFooderPullOnView:(UIScrollView *)View waitTime:(CGFloat)waitTime action:(void (^)())action;
/**
 *  上拉加载完成
 */
-(void)footerEndRefreshingOnView:(UIScrollView *)view;
/**
 *  移除上拉加载
 */
-(void)removeFooterOnView:(UIScrollView *)view;
/**
 *  下拉刷新
 */
-(void)addHeaderPullOnView:(UIScrollView *)View waitTime:(CGFloat)waitTime action:(void (^)())action;
/**
 *  下拉刷新完成
 */
-(void)headerEndRefreshingOnView:(UIScrollView *)view;
/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing:(UIScrollView*)scroll;

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing:(UIScrollView*)scroll;

/**
 *  存储value
 */
-(void)saveInMyLocalStoreForValue:(id)value atKey:(NSString *)key;
/**
 *  获取value
 */
-(id)getValueInMyLocalStoreForKey:(NSString *)key;
/**
 *  删除value
 */
-(void)DeleteValueInMyLocalStoreForKey:(NSString *)key;


@end
