//
//  UIViewController+BuriedPoint.m
//  BasicFramework
//
//  Created by Rainy on 2017/4/18.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "UIViewController+BuriedPoint.h"
#import "BuriedPointManager.h"

@implementation UIViewController (BuriedPoint)

+ (void)buriedPointForViewController {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector1 = @selector(viewWillAppear:);
        SEL swizzledSelector1 = @selector(swiz_viewWillAppear:);
        [BuriedPointManager swizzlingInClass:[self class]
                     originalSelector:originalSelector1
                     swizzledSelector:swizzledSelector1];
        
        SEL originalSelector2 = @selector(viewWillDisappear:);
        SEL swizzledSelector2 = @selector(swiz_viewWillDisappear:);
        [BuriedPointManager swizzlingInClass:[self class]
                     originalSelector:originalSelector2
                     swizzledSelector:swizzledSelector2];
    });
}
#pragma mark - Method Swizzling
- (void)swiz_viewWillAppear:(BOOL)animated
{
    
    [self inject_viewWillAppear];
    [self swiz_viewWillAppear:animated];
}
- (void)swiz_viewWillDisappear:(BOOL)animated
{
    
    [self inject_viewWillDisappear];
    [self swiz_viewWillAppear:animated];
}

#pragma mark - hook
- (void)inject_viewWillAppear
{
    NSString *pageID = [self pageEventID:YES];
    if (pageID) {
        
        //send event to server !
    }
}
- (void)inject_viewWillDisappear
{
    NSString *pageID = [self pageEventID:NO];
    if (pageID) {
        
        //send event to server !
    }
}
#pragma mark - get eventID
- (NSString *)pageEventID:(BOOL)enterPage
{
    
    NSDictionary *configDict = [self dictionaryFromUserStatisticsConfigPlist];
    NSString *selfClassName = NSStringFromClass([self class]);
    return configDict[selfClassName][@"PageEventIDs"][enterPage ? @"Enter" : @"Leave"];
}

- (NSDictionary *)dictionaryFromUserStatisticsConfigPlist
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BuriedPoint" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}

@end
