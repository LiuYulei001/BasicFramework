

/**
 *  提醒消失时间
 */
#define HUD_DismisTime 0.5
/**
 *  透明度
 */
#define kAlpha 0.3
/**
 *  获取Window
 */
#define kWindow [UIApplication sharedApplication].keyWindow
/**
 *  获取mainScreen的bounds
 */
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height
/**
 *  版本号
 *
 *  @param  CFBundleShortVersionString
 *
 *  @return kVersion
 */
#define kVersion [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]
/**
 *  当前网络状态
 */
#define kNetworkType [AppUtility getNetworkType]
/**
 *  用户惟一标示
 */
#define USER_ID [FileCacheManager getValueInMyLocalStoreForKey:KEY_USER_ID]

/**
 *  持久化 KEY 值
 */
#define kNoNetwork @"no network"
#define KEY_USER_ID @"USER_ID"
/**
 *  懒人简化书写宏
 */
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
/**
 *  请求提示文字
 */
#define Loading @"请稍后..."
#define Request_Failure @"失败"
#define Request_Success @"成功"
#define Request_NOMore @"已加载全部"
#define Request_NoNetwork @"请检查网络链接"
#define DownLoad_Failure @"下载失败"
/**
 *  iPhone or iPad
 */
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
/**
 *  NSLog
 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//NSCoding协议遵循
#define kObjectCodingAction  -(id)initWithCoder:(NSCoder *)aDecoder\
{\
self = [super init];\
if (self) {\
[self autoDecode:aDecoder];\
\
}\
return self;\
}\
-(void)encodeWithCoder:(NSCoder *)aCoder\
{\
[self autoEncodeWithCoder:aCoder];\
}\
-(void)setValue:(id)value forUndefinedKey:(NSString *)key\
{\
\
}








