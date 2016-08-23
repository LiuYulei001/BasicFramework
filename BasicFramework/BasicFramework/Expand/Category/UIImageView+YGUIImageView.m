//
//  UIImageView+YGUIImageView.m
//  
//
//  Created by 星空浩 on 16/6/27.
//
//

#import "UIImageView+YGUIImageView.h"
@implementation UIImageView (YGUIImageView)


- (void)yg_setImage:(NSURL*)imgUrl placeholderImage:(UIImage*)placeholderImage;
{
    [self sd_setImageWithURL:imgUrl placeholderImage:placeholderImage];
}
- (void)yg_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;
{
    [self sd_setImageWithPreviousCachedImageWithURL:url placeholderImage:placeholder options:0 progress:progressBlock completed:completedBlock];
}
- (void)yg_cancelCurrentImageLoad;
{
    [self sd_cancelCurrentImageLoad];
}
@end
