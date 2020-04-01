//
//  PhotoSelectorManager.m
//  CashBack
//
//  Created by Rainy on 2017/9/21.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#define kMaxChooseCount 6

#import "PhotoSelectorManager.h"
#import "GWLPhotoLibrayController.h"

@implementation PhotoSelectorManager

+ (void)photoSelectorForTarget:(UIViewController *)target finished:(void(^)(NSArray *images))finished {
    
    GWLPhotoLibrayController *photoSelector = [GWLPhotoLibrayController photoLibrayControllerWithBlock:^(NSArray *images) {
        finished(images);
    }];
    photoSelector.maxCount = kMaxChooseCount;
    photoSelector.multiAlbumSelect = YES;
    [target presentViewController:photoSelector animated:YES completion:nil];
}

@end
