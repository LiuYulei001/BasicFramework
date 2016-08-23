//
//  LYLIMGScrollView.h
//  SPI-Piles
//
//  Created by SPI-绿能宝 on 16/5/16.
//  Copyright © 2016年 北京SPI绿能宝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYLIMGScrollViewDelegate <NSObject>

- (void)touchedImageViewAction:(id)sender;

@end
@class LYLPageControl;
@interface LYLIMGScrollView : UIScrollView

@property(nonatomic,weak)id<LYLIMGScrollViewDelegate> LYLScrDelegate;

@property(nonatomic,strong)LYLPageControl *pageControl;

-(instancetype)initWithImgURLs:(NSArray *)imgs withIndexPage:(NSInteger)page_number;

-(instancetype)initWithImgs:(NSArray *)imgs withIndexPage:(NSInteger)page_number;


@end
