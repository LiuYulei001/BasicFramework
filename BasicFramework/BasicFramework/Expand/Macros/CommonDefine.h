
/**
 *  user
 */
#define USER_ID [FileCacheManager getValueInMyLocalStoreForKey:kUSER_ID_KEY]
/**
 *  Bounds
 */
#define kWindow [UIApplication sharedApplication].keyWindow
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height
/**
 *  Version
 */
#define kVersion [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]
#define kSystemVersion [[UIDevice currentDevice].systemVersion floatValue]
/**
 *  Network
 */
#define kNetworkType [AppUtility getNetworkType]


/**
 *  lazy
 */
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

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
/**
 *  @param instead 需要给用户提醒的话,例子：XMCDeprecated("此方法已经过期")
 */
#define XMCDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)




//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
//
//#endif







