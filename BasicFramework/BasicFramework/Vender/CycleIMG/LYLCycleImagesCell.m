//
//  LYLCycleImagesCell.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/17.
//  Copyright © 2017年 Rainy. All rights reserved.
//
#define kPlaceholderImage @""

#import "LYLCycleImagesCell.h"
#import "LYLZoomProportion.h"

@interface LYLCycleImagesCell ()


@end

@implementation LYLCycleImagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.transform = kZoomProportion;
    
}
-(void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}
-(void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self.imageView set_Image:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:kPlaceholderImage]];
}
@end
