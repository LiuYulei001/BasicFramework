//
//  GWLPhotoLibrayController.m
//  GWLPhotoSelector
//
//  Created by GaoWanli on 15/7/23.
//  Copyright (c) 2015年 GWL. All rights reserved.
//

#import "GWLPhotoLibrayController.h"
#import "GWLPhotoGroupTableViewController.h"

@interface GWLPhotoLibrayController ()

@property (nonatomic, copy) kGWLPhotoSelector_ArrayBlock block;
@property(nonatomic, strong) GWLPhotoGroupTableViewController *photoGroupTableViewController;
@property(nonatomic, strong) ALAssetsLibrary *library;
@property(nonatomic, strong) NSMutableArray *photoGroupArray;
@property (nonatomic, strong) PHImageRequestOptions *imageOptions;

@end

@implementation GWLPhotoLibrayController

+ (instancetype)photoLibrayControllerWithBlock:(kGWLPhotoSelector_ArrayBlock) block {
    return [[self alloc]initWithBlock:block];
}

- (instancetype)initWithBlock:(kGWLPhotoSelector_ArrayBlock) block {
    _block = [block copy];
    return [super initWithRootViewController:self.photoGroupTableViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupImagePickerController];
}

- (void)setupImagePickerController {
    __weak typeof (self) selfVc = self;
    if (kGWLPhotoSelector_Above_iOS8) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status != PHAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [selfVc.photoGroupTableViewController showErrorMessageView];
                });
            }else {
                PHFetchResult *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
                [collections enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL *stop) {
                    [selfVc photoGroupWithCollection:collection];
                }];
                
                collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
                [collections enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL *stop) {
                    if (collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                        [selfVc photoGroupWithCollection:collection];
                    }
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    selfVc.photoGroupTableViewController.photoGroupArray = selfVc.photoGroupArray;
                });
            }
        }];
    }else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *error) {
                if (error != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [selfVc.photoGroupTableViewController showErrorMessageView];
                    });
                }
            };
            [selfVc.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *aLAssets, BOOL* stop){
                if (aLAssets != nil) {
                    NSString *groupName = [aLAssets valueForProperty:ALAssetsGroupPropertyName];
                    UIImage *posterImage = [UIImage imageWithCGImage:[aLAssets posterImage]];
                    
                    GWLPhotoGroup *photoGroup = [[GWLPhotoGroup alloc]init];
                    photoGroup.groupName = groupName;
                    photoGroup.groupIcon = posterImage;
                    [selfVc.photoGroupArray addObject:photoGroup];
                    
                    [aLAssets enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop){
                        if (result != NULL) {
                            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                                GWLPhotoALAssets *photoALAssets = [[GWLPhotoALAssets alloc]init];
                                photoALAssets.photoALAsset = result;
                                photoALAssets.selected = NO;
                                [photoGroup.photoALAssets addObject:photoALAssets];
                            }
                        }
                    }];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        selfVc.photoGroupTableViewController.photoGroupArray = selfVc.photoGroupArray;
                    });
                }
            } failureBlock:failureblock];
        });
    }
}

- (void)photoGroupWithCollection:(PHAssetCollection *)collection {
    [self coverImageWithCollection:collection completion:^(UIImage *image) {
        GWLPhotoGroup *photoGroup = [[GWLPhotoGroup alloc]init];
        photoGroup.groupName = collection.localizedTitle;
        photoGroup.groupIcon = image;
        [self.photoGroupArray addObject:photoGroup];
        [self photoGroupSetALAsset:photoGroup collection:collection];
    }];
}

- (void)coverImageWithCollection:(PHAssetCollection *)collection completion:(kGWLPhotoSelector_imageBlock)completion {
    PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    [assetResult enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        if (asset.mediaType == PHAssetMediaTypeImage) {
            CGSize targetSize = CGSizeMake(kGWLPhotoSelector_Cell_Height, kGWLPhotoSelector_Cell_Height);
            [self imageWithAsset:asset targetSize:targetSize completion:^(UIImage *image) {
                completion(image);
                *stop = YES;
            }];
        }
    }];
}

- (void)photoGroupSetALAsset:(GWLPhotoGroup *)photoGroup collection:(PHAssetCollection *)collection {
    PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    [assetResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        if (asset.mediaType == PHAssetMediaTypeImage) {
            GWLPhotoALAssets *photoALAssets = [[GWLPhotoALAssets alloc]init];
            photoALAssets.photoAsset = asset;
            photoALAssets.selected = NO;
            [photoGroup.photoALAssets addObject:photoALAssets];
        }
    }];
}

- (void)imageWithAsset:(PHAsset *)asset targetSize:(CGSize)targetSize completion:(kGWLPhotoSelector_imageBlock)completion {
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeDefault options:self.imageOptions resultHandler:^(UIImage *result, NSDictionary *info) {
        completion(result);
    }];
}

#pragma mark - getter && setter
- (GWLPhotoGroupTableViewController *)photoGroupTableViewController {
    if (!_photoGroupTableViewController) {
        _photoGroupTableViewController = [[GWLPhotoGroupTableViewController alloc]init];
    }
    return _photoGroupTableViewController;
}

- (ALAssetsLibrary *)library {
    if (!_library) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}

- (NSMutableArray *)photoGroupArray {
    if (!_photoGroupArray) {
        _photoGroupArray = [NSMutableArray array];
    }
    return _photoGroupArray;
}

- (PHImageRequestOptions *)imageOptions {
    if (!_imageOptions) {
        _imageOptions = [[PHImageRequestOptions alloc] init];
        _imageOptions.synchronous = YES;
    }
    return _imageOptions;
}

- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    self.photoGroupTableViewController.maxCount = maxCount;
    self.photoGroupTableViewController.block = self.block;
}

- (void)setMultiAlbumSelect:(BOOL)multiAlbumSelect {
    _multiAlbumSelect = multiAlbumSelect;
    self.photoGroupTableViewController.multiAlbumSelect = multiAlbumSelect;
}

@end

@implementation GWLPhotoGroup

- (NSMutableArray *)photoALAssets {
    if (!_photoALAssets) {
        _photoALAssets = [NSMutableArray array];
    }
    return _photoALAssets;
}

- (void)setGroupName:(NSString *)groupName {
    if ([groupName isEqualToString:@"Camera Roll"]) {
        groupName = @"相机胶卷";
    }
    _groupName = groupName;
}

@end

@implementation GWLPhotoALAssets

@end
