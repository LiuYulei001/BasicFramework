//
//  UIImage+Extension.h
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

#pragma mark take image to this size
-(UIImage*)scaleToSize:(CGSize)size;
#pragma mark restore image to befor
-(UIImage *)restoreMyimage;
#pragma mark color -> image
+ (UIImage *)createImageWithColor:(UIColor*)color;
#pragma mark image -> color
- (UIImage *)imageWithColor:(UIColor *)color;
#pragma mark - Set the image rotation Angle
- (UIImage*)image_RotatedByAngle:(CGFloat)Angle;
#pragma mark - image from view
- (UIImage *)imageFromView:(UIView *)theView;
/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)colorAtPoint:(CGPoint )point;
//more accurate method ,colorAtPixel 1x1 pixel
/**
 *  @brief  取某一像素的颜色
 *
 *  @param point 一像素
 *
 *  @return 颜色
 */
- (UIColor *)colorAtPixel:(CGPoint)point;
/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */
+ (UIImage*)covertToGrayImageFromImage:(UIImage*)sourceImage;





#pragma mark - blur image
- (UIImage *)lightImage;
- (UIImage *)extraLightImage;
- (UIImage *)darkImage;
- (UIImage *)tintedImageWithColor:(UIColor *)tintColor;

- (UIImage *)blurredImageWithRadius:(CGFloat)blurRadius;
- (UIImage *)blurredImageWithSize:(CGSize)blurSize;
- (UIImage *)blurredImageWithSize:(CGSize)blurSize
                        tintColor:(UIColor *)tintColor
            saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                        maskImage:(UIImage *)maskImage;

#pragma mark - Blur
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
@end
