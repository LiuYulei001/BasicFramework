//
//  LYLIMGBrowse.h
//  SPI-Piles
//
//  Created by SPI-绿能宝 on 16/4/5.
//  Copyright © 2016年 北京SPI绿能宝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYLIMGBrowseDelegate <NSObject>

@optional
- (void)singleTappedImageViewAction:(id)sender;
- (void)doubleTappedImageViewAction:(id)sender withEvent:(UIEvent *)event;


@end


@interface LYLIMGBrowse : UIScrollView

@property(nonatomic,weak)id<LYLIMGBrowseDelegate> LYL_delegate;


-(instancetype)initWithFrame:(CGRect)frame imgURL:(NSString *)img_url img:(UIImage *)img;

@end
