//
//  UIBarButtonItem+DFYGExtension.h
//  DFYGProductDemo
//
//  Created by victor on 16/7/5.
//  Copyright © 2016年 DFYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DFYGExtension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
@end
