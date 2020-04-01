//
//  UIControl+BuriedPoint.m
//  BasicFramework
//
//  Created by Rainy on 2017/4/18.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "UIControl+BuriedPoint.h"
#import "BuriedPointManager.h"

@implementation UIControl (BuriedPoint)

+ (void)buriedPointForControl {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
        [BuriedPointManager swizzlingInClass:[self class]
                     originalSelector:originalSelector
                     swizzledSelector:swizzledSelector];
    });
}

#pragma mark - Method Swizzling
- (void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    [self performUserStastisticsAction:action to:target forEvent:event];
    [self swiz_sendAction:action to:target forEvent:event];
}

- (void)performUserStastisticsAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    NSLog(@"\n***hook success.\n[1]action:%@\n[2]target:%@ \n[3]event:%ld", NSStringFromSelector(action), target, (long)event);
    
    NSDictionary *configDict = [self dictionaryFromUserStatisticsConfigPlist];
    NSString *actionString = NSStringFromSelector(action);//获取SEL string
    NSString *targetName = NSStringFromClass([target class]);//viewController name
    NSString * eventID = configDict[targetName][@"ControlEventIDs"][actionString];
    if (eventID) {
        
        //send event to server !
    }
}
- (NSDictionary *)dictionaryFromUserStatisticsConfigPlist
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BuriedPoint" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}

@end
