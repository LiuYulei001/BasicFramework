//
//  UIImageView+GIF.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/8.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GIF)
//帧视图合集
@property (nonatomic,strong)NSArray *image_array;

- (void)showGifImageWithData:(NSData *)data;
- (void)showGifImageWithURL:(NSURL *)url;

@end
