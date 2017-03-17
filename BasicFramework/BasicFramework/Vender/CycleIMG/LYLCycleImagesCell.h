//
//  LYLCycleImagesCell.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/17.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYLCycleImagesCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,copy)NSString *imageUrl;

@end
