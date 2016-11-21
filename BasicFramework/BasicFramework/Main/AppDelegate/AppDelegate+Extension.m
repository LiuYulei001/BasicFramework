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
#import "BasicMainNC.h"

@implementation AppDelegate (Extension)

-(void)setMyWindowAndRootViewController
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[BasicMainNC alloc]initWithRootViewController:[[HomePageVC alloc]init]];
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












@end
