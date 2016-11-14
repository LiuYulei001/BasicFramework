

#define  KEY_USERNAME_PASSWORD @"KEY_USERNAME_PASSWORD"

#define kSaveStatic [NSUserDefaults standardUserDefaults]

#import "AppSingle.h"
#import "MJRefresh.h"
#import <MyUUID/SPIMyUUID.h>

@implementation AppSingle
+(instancetype)Shared
{
    static AppSingle *_appSingle = nil;
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        _appSingle = [[self alloc]init];
    });
    return _appSingle;
}
- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}
-(void)saveInMyLocalStoreForValue:(id)value atKey:(NSString *)key
{
    [kSaveStatic setValue:value forKey:key];
    [kSaveStatic synchronize];
}
-(id)getValueInMyLocalStoreForKey:(NSString *)key
{
    return [kSaveStatic objectForKey:key];
}
-(void)DeleteValueInMyLocalStoreForKey:(NSString *)key
{
    [kSaveStatic removeObjectForKey:key];
    [kSaveStatic synchronize];
}

-(void)addFooderPullOnView:(UIScrollView *)View waitTime:(CGFloat)waitTime action:(void (^)())action
{
    [View addFooterWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(waitTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            action();
            
            
        });
    }];
}
-(void)footerEndRefreshingOnView:(UIScrollView *)view
{
    [view footerEndRefreshing];
}
-(void)removeFooterOnView:(UIScrollView *)view
{
    [view removeFooter];
}

-(void)addHeaderPullOnView:(UIScrollView *)View waitTime:(CGFloat)waitTime action:(void (^)())action
{
    [View addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(waitTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            action();

        });
    }];
}
- (void)headerEndRefreshing:(UIScrollView *)scroll
{
    [scroll headerEndRefreshing];

}
- (void)headerBeginRefreshing:(UIScrollView *)scroll
{
    [scroll headerBeginRefreshing];

}
-(void)headerEndRefreshingOnView:(UIScrollView *)view
{
    [view headerEndRefreshing];
}

-(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[SPIMyUUID load:KEY_USERNAME_PASSWORD];
    
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        [SPIMyUUID save:KEY_USERNAME_PASSWORD data:strUUID];
        
    }
    return strUUID;
}
-(NSArray *)getFilePathsFromMainBundleForFileType:(NSString *)fileType
{
    NSString *bundlePath = [[NSBundle mainBundle]resourcePath];
    
    NSArray *arrMp3 = [NSBundle pathsForResourcesOfType:fileType inDirectory:bundlePath];
    
    return arrMp3;
}

















@end
