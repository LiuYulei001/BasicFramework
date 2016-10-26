//
//  UIImageView+Extension.m
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

- (void)set_Image:(NSURL*)imgUrl placeholderImage:(UIImage*)placeholderImage;
{
    [self sd_setImageWithURL:imgUrl placeholderImage:placeholderImage];
}
- (void)set_ImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;
{
    [self sd_setImageWithPreviousCachedImageWithURL:url placeholderImage:placeholder options:0 progress:progressBlock completed:completedBlock];
}
- (void)cancel_CurrentImageLoad;
{
    [self sd_cancelCurrentImageLoad];
}

@end
