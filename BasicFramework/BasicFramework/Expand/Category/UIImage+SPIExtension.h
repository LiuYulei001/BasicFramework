//
//  UIImage+SPIExtension.h
//  SPI-Piles
//
//  Created by SPI-绿能宝 on 16/3/7.
//  Copyright © 2016年 北京SPI绿能宝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SPIExtension)

#pragma mark take image to this size
-(UIImage*)scaleToSize:(CGSize)size;
#pragma mark restore image to befor
-(UIImage *)restoreMyimage;
#pragma mark color -> image
+ (UIImage *)createImageWithColor:(UIColor*)color;
#pragma mark image -> color
- (UIImage *)imageWithColor:(UIColor *)color;

@end
