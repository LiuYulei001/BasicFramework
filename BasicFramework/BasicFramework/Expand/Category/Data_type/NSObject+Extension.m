//
//  NSObject+Extension.m
//  BasicFramework
//
//  Created by Rainy on 2017/1/13.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>
#import <PhotosUI/PhotosUI.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation NSObject (Extension)

static char const dispatch_source_timer_;

-(void)startTimingWithTimeOut:(NSTimeInterval)timeout TimeInterval:(NSTimeInterval)TimeInterval timingChildThreadsBlock:(timingChildThreadsBlock)timingChildThreadsBlock
{
    __block NSTimeInterval timeOut = timeout; //The countdown time
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = objc_getAssociatedObject(self, &dispatch_source_timer_);
    if (!_timer) {
        
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        objc_setAssociatedObject(self, &dispatch_source_timer_, _timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),TimeInterval*NSEC_PER_SEC, 0); //To perform a second
    
    dispatch_source_set_event_handler(_timer, ^{
        
        timeOut -= TimeInterval;
        
        if(timeOut < 0)
        { //it is time to
            dispatch_source_cancel(_timer);
        }else{
            
            
            timingChildThreadsBlock(self,timeOut);
            
            
        }
        
        
        
        
    });
    dispatch_resume(_timer);
    
    
}
-(void)stopCountDown{
    
    dispatch_source_t _timer = objc_getAssociatedObject(self, &dispatch_source_timer_);
    if (_timer) {
        
        dispatch_source_cancel(_timer);
    }
}
-(void)dispatch_get_main_queue:(void(^)())main_queue{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        main_queue();
    });
    
}
-(dispatch_source_t)dispatch_source_tmier
{
    return objc_getAssociatedObject(self, &dispatch_source_timer_);
}
-(void)setDispatch_source_tmier:(dispatch_source_t)dispatch_source_tmier
{
    objc_setAssociatedObject(self, &dispatch_source_timer_, dispatch_source_tmier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}






#pragma mark - 获取最新一张图片
+ (void)GetlatestImageForTakeScreenshot:(BOOL)isTakeScreenshot finished:(void (^)(UIImage *image))finished {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((isTakeScreenshot ? 1 : 0) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
        PHAsset *asset = [assetsFetchResults firstObject];
        PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
        [imageManager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            if (imageData) {
                finished([UIImage imageWithData:imageData]);
            }
        }];
    });
}
#pragma mark - 获取相册所有图片
+(void)GetAllImagesInPhotoAlbumFinished:(void (^)(NSMutableArray *images))Finished
{
    __block NSMutableArray *arrayOfimages = [NSMutableArray array];
    [self GetImageInPhotoAlbumOneByOne:^(UIImage *currentImage, NSUInteger count) {
        [arrayOfimages addObject:currentImage];
        if (arrayOfimages.count == count) {
            
            Finished(arrayOfimages);
        }
    }];
}
+ (void)GetImageInPhotoAlbumOneByOne:(void (^)(UIImage *currentImage, NSUInteger count))finishing{
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    [assetsFetchResults enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PHAsset *asset = obj;
        if (asset.mediaType == PHAssetMediaTypeImage) {
            
            PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
            [imageManager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                if (imageData) {
                    finishing([UIImage imageWithData:imageData],[assetsFetchResults countOfAssetsWithMediaType:PHAssetMediaTypeImage]);
                }
            }];
        }
    }];
}
+(void)iPhoneVibration
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
