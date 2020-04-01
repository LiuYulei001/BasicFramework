//
//  MainHelper.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/7.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "MainHelper.h"

static MainHelper *helper = nil;

@implementation MainHelper

+(instancetype)shareHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[MainHelper alloc] init];
    });
    
    return helper;
}


#pragma mark - 神奇的load方法
+(void)load{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

#pragma mark ListeningAppDelegate
        [[MainHelper shareHelper] ListeningLifeCycleAndRegisteredAPNS];
    });
    
}

- (void)ListeningLifeCycleAndRegisteredAPNS
{
    //注册AppDelegate默认回调监听
    [self _setupAppDelegateNotifications];
    
    //注册apns
    [self _registerRemoteNotification];
    
    
}
// 监听系统生命周期回调，以便将需要的事件传给SDK
- (void)_setupAppDelegateNotifications
{
    [kNotificationCenter addObserver:self selector:@selector(appWillResignActiveNotif:)name:UIApplicationWillResignActiveNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(appDidBecomeActiveNotif:)name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(appWillEnterForegroundNotif:)name:UIApplicationWillEnterForegroundNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(appWillEnterBackgroundNotif:)name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(application_OpenURL_SourceApplication_Annotation:) name:_NotificationNameForAppDelegateBackOff object:nil];
    [kNotificationCenter addObserver:self selector:@selector(userDidTakeScreenshot:)name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}
//app-app or web-app互调-回调
- (void)application_OpenURL_SourceApplication_Annotation:(NSNotification *)notif
{
    
    NSString *urlStr = [notif.object absoluteString];
    if ([urlStr hasPrefix:@"basicframework://"]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:urlStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)appWillResignActiveNotif:(NSNotification*)notif
{
    NSLog(@"程序进入非活跃状态！");
}

- (void)appDidBecomeActiveNotif:(NSNotification*)notif
{
    NSLog(@"程序进入活跃状态！");
}

- (void)appWillEnterBackgroundNotif:(NSNotification*)notif
{
    NSLog(@"程序进入后台！");
}

- (void)appWillEnterForegroundNotif:(NSNotification*)notif
{
    NSLog(@"程序进入前台！");
}

- (void)userDidTakeScreenshot:(NSNotification *)notification
{
    
    //人为截屏, 模拟用户截屏行为, 获取所截图片
    [MainHelper GetlatestImageForTakeScreenshot:YES finished:^(UIImage *image) {
        
    }];
    
    
}

#pragma mark - register apns
// 注册推送
- (void)_registerRemoteNotification
{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                
                                                (UIUserNotificationTypeBadge |
                                                 UIUserNotificationTypeSound |
                                                 UIUserNotificationTypeAlert)
                                                                                 categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
#else
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge |
          UIUserNotificationTypeSound |
          UIUserNotificationTypeAlert)];
        
#endif
        
    }
#endif
}


#pragma mark - Local push
static UILocalNotification *notif;

- (void)localPush {
    
    notif = [UILocalNotification new];
    notif.fireDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
    notif.alertBody = @"一天后提示push";
    notif.userInfo = @{@"key":@"value"};
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
}
- (void)cancelLocalPush {
    
    [[UIApplication sharedApplication] cancelLocalNotification:notif];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

#pragma mark - app进入后台还将继续运行几分钟（iOS7之前为十分钟，之后为三分钟）
- (void)beginBackgroundTask {
    
    UIApplication *app = [UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier taskId = [app beginBackgroundTaskWithExpirationHandler:^{
        
        [app endBackgroundTask:taskId];
        
        taskId = UIBackgroundTaskInvalid;
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        while (true) {
            
            int remainingTime = app.backgroundTimeRemaining;
            if (remainingTime <= 5) {
                break;
            }
            
            NSLog(@"remaining background time = %d",remainingTime);
            
            [NSThread sleepForTimeInterval:1.0];
        }
        [app endBackgroundTask:taskId];
        taskId = UIBackgroundTaskInvalid;
    });
    
    
}




- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}

@end
