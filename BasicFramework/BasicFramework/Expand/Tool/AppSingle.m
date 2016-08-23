//
//  AppSingle.m
//  PreheatDemo
//
//  Created by 星空浩 on 16/6/28.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

#define kSaveStatic [NSUserDefaults standardUserDefaults]

#import "AppSingle.h"
#import "MJRefresh.h"
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
-(NSMutableAttributedString *)getOtherColorString:(NSString *)string Color:(UIColor *)Color font:(CGFloat)font inStr:(NSString *)instr
{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]init];
    
    if (![NSString isBlankString:instr]) {
        
        NSMutableString *temp = [NSMutableString stringWithString:instr];
        
        NSRange range = [temp rangeOfString:string];
        
        str = [[NSMutableAttributedString alloc] initWithString:temp];
        [str addAttribute:NSForegroundColorAttributeName value:Color range:range];
        if (font) {
            
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
        }
        
    }
    return str;
    
    
}
-(void)addBorderOnView:(UIView *)view cornerRad:(CGFloat)cornerRad lineCollor:(UIColor *)collor lineWidth:(CGFloat)lineWidth
{
    view.layer.borderWidth = lineWidth;
    view.cornerRad = cornerRad;
    view.layer.borderColor = collor.CGColor;
    
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
