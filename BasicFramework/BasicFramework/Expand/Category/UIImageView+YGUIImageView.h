//
//
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

typedef void(^SDWebImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);
typedef void(^SDWebImageCompletionBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL);

@interface UIImageView (YGUIImageView)

/**
 *  YG图片加载
 *
 *  @param imgUrl           图片地址
 *  @param placeholderImage 备用图片
 */
- (void)yg_setImage:(NSURL*)imgUrl placeholderImage:(UIImage*)placeholderImage;
/**
 *  有加载进度的图片加载
 *
 *  @param url            图片地址
 *  @param placeholder    备用图片
 *  @param progressBlock  加载进度block
 *  @param completedBlock 加载完成block
 */
- (void)yg_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;
/**
 *  取消下载
 */
- (void)yg_cancelCurrentImageLoad;

@end
