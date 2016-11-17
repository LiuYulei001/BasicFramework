//
//  UIImageView+Extension.h
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <SDWebImage/UIImageView+WebCache.h>

typedef void(^SDWebImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);
typedef void(^SDWebImageCompletionBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL);

@interface UIImageView (Extension)


- (void)set_Image:(NSURL*)imgUrl placeholderImage:(UIImage*)placeholderImage;

- (void)set_ImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;
/**
 *  取消下载
 */
- (void)cancel_CurrentImageLoad;

// 画水印
// 图片水印
- (void) setImage:(UIImage *)image withWaterMark:(UIImage *)mark inRect:(CGRect)rect;
// 文字水印
- (void) setImage:(UIImage *)image withStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
- (void) setImage:(UIImage *)image withStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;

@end
