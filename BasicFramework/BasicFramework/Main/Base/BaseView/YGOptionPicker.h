//
//  YGOptionPicker.h
//  CashBack
//
//  Created by Rainy on 2017/10/17.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGOptionPicker : NSObject

+ (void)showOptionPicker:(NSArray *)dataSource
         determineChoose:(void(^)(NSInteger index,NSString *title))determineChoose;

@end
