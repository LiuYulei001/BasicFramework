//
//  AppDelegate+Extension.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/7.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import "MainHelper.h"
#import "AvoidCrash.h"
#import "HomePageVC.h"


@implementation AppDelegate (Extension)

-(void)setMyWindowAndRootViewController
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[HomePageVC alloc]init];
}

- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [[MainHelper shareHelper]easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
}

-(UIImageView *)GetPortraitIMG
{
    CGSize viewSize = kWindow.bounds.size;
    NSString *viewOrientation = @"Portrait";//横屏 @"Landscape"
    __block NSString *launchImage = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    [imagesDict enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary* dict = (NSDictionary *)obj;
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImage = dict[@"UILaunchImageName"];
        }
        
    }];
    
    UIImageView *launchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImage]];
    launchView.frame = kWindow.bounds;
    
    return launchView;
}



-(void)FaultTolerance
{
    [AvoidCrash becomeEffective];
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [kNotificationCenter addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    
}
-(void)dealwithCrashMessage:(NSNotification *)notification
{
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    NSLog(@"%@",notification.userInfo);
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
            
            [[AppSingle Shared]saveInMyLocalStoreForValue:@"0" atKey:kReachability];
            
            break;
        case 1:
            
            [[AppSingle Shared]saveInMyLocalStoreForValue:@"2G" atKey:kReachability];
            
            break;
        case 2:
            
            [[AppSingle Shared]saveInMyLocalStoreForValue:@"3G" atKey:kReachability];
            
            break;
        case 3:
            
            [[AppSingle Shared]saveInMyLocalStoreForValue:@"4G" atKey:kReachability];
            
            break;
        case 5:
            
            [[AppSingle Shared]saveInMyLocalStoreForValue:@"WIFE" atKey:kReachability];
            
            break;
            
        default:
            break;
    }
    
}
-(void)setReachability
{
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [reach startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityAction) name:kReachabilityChangedNotification object:nil];
}










@end
