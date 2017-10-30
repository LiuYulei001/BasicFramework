//
//  GWLPhotoLibrayController.h
//  GWLPhotoSelector
//
//  Created by GaoWanli on 15/7/23.
//  Copyright (c) 2015年 GWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWLPhotoSelectorHeader.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface GWLPhotoLibrayController : UINavigationController

/**最多能选择的照片数量*/
@property(nonatomic, assign) NSInteger maxCount;
/**是否可以跨相册选择*/
@property (nonatomic, assign) BOOL multiAlbumSelect;

+ (instancetype)photoLibrayControllerWithBlock:(kGWLPhotoSelector_ArrayBlock) block;

@end

@interface GWLPhotoGroup : NSObject

@property(nonatomic, copy) NSString *groupName;
@property(nonatomic, strong) UIImage *groupIcon;
@property(nonatomic, strong) NSMutableArray *photoALAssets;

@end

@interface GWLPhotoALAssets : NSObject

@property(nonatomic ,strong) ALAsset *photoALAsset;
@property(nonatomic ,strong) PHAsset *photoAsset;
@property(nonatomic, assign, getter=isSelected) BOOL selected;

@end
