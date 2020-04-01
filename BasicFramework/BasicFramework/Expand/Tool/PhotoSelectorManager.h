//
//  PhotoSelectorManager.h
//  CashBack
//
//  Created by Rainy on 2017/9/21.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoSelectorManager : NSObject

+ (void)photoSelectorForTarget:(UIViewController *)target finished:(void(^)(NSArray *images))finished;

@end
