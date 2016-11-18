//
//  UITextField+Extension.m
//  BasicFramework
//
//  Created by Rainy on 16/11/3.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

-(void)LeftImageNamed:(NSString *)Named IMG_size:(CGSize)IMG_size
{
    
    UIImageView *rightView = [[UIImageView alloc]init];
    rightView.image = [UIImage imageNamed:Named];
    rightView.size = IMG_size;
    rightView.contentMode = UIViewContentModeCenter;
    self.leftView = rightView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
}

@end
