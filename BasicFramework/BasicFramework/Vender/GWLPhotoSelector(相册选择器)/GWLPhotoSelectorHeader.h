//
//  GWLPhotoSelectorHeader.h
//  GWLPhotoSelector
//
//  Created by GaoWanli on 15/7/23.
//  Copyright (c) 2015年 GWL. All rights reserved.
//

#ifndef GWLPhotoSelector_GWLPhotoSelectorHeader_h
#define GWLPhotoSelector_GWLPhotoSelectorHeader_h

typedef void(^kGWLPhotoSelector_ArrayBlock)(NSArray *images);
typedef void(^kGWLPhotoSelector_imageBlock)(UIImage *image);
#define kGWLPhotoSelector_Cell_Height 55.0     // cell高度
#define kGWLPhotoSelector_RowPhotoCount 4      // 一行显示的图片个数
#define kGWLPhotoSelector_ErrorMessageText @"未能读取到任何照片"
#define kGWLPhotoSelector_Above_iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#endif
