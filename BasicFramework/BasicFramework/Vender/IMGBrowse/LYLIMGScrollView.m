//
//  LYLIMGScrollView.m
//  SPI-Piles
//
//  Created by SPI-绿能宝 on 16/5/16.
//  Copyright © 2016年 北京SPI绿能宝. All rights reserved.
//

#define kIMG_Space 20

#import "LYLIMGScrollView.h"
#import "LYLIMGBrowse.h"
#import "LYLPageControl.h"
@interface LYLIMGScrollView ()<UIScrollViewDelegate,LYLIMGBrowseDelegate>



@end



@implementation LYLIMGScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithImgs:(NSArray *)imgs withIndexPage:(NSInteger)page_number
{
    self = [super init];
    if (self) {
        
        self.pagingEnabled = YES;
        self.bounces = YES;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        
        CGRect rect = kWindow.bounds;
        rect.size.width += kIMG_Space * 2;
        self.bounds = rect;
        self.center = CGPointMake(kWindow.Sw *0.5, kWindow.Sh *0.5);
        
        CGFloat y = 0;
        __block CGFloat w = kWindow.Sw;
        CGFloat h = kWindow.Sh;
     
        for (int i = 0; i < imgs.count; i++) {
            
            CGFloat x = kIMG_Space + i * (kIMG_Space * 2 + w);
            
            LYLIMGBrowse *img_scr = [[LYLIMGBrowse alloc]initWithFrame:CGRectMake(x, y, w, h) imgURL:nil img:imgs[i]];
            
            img_scr.LYL_delegate = self;
            [self addSubview:img_scr];

            
        }

        self.contentSize = CGSizeMake(self.subviews.count * self.frame.size.width, kWindow.Sh);
        
        self.contentOffset = CGPointMake(page_number * self.frame.size.width, 0);
        
        self.pageControl.numberOfPages = imgs.count;
        self.pageControl.currentPage = page_number;
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrame:) name:UIDeviceOrientationDidChangeNotification object:nil];
    return self;

}
-(instancetype)initWithImgURLs:(NSArray *)imgs withIndexPage:(NSInteger)page_number
{
    self = [super init];
    if (self) {
        
        self.frame = kWindow.bounds;
        self.pagingEnabled = YES;
        self.bounces = YES;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        
        CGRect rect = kWindow.bounds;
        rect.size.width += kIMG_Space * 2;
        self.bounds = rect;
        self.center = CGPointMake(kWindow.Sw *0.5, kWindow.Sh *0.5);
        
        CGFloat y = 0;
        __block CGFloat w = kWindow.Sw;
        CGFloat h = kWindow.Sh;
        
        
        for (int i = 0; i < imgs.count; i++) {
            
            CGFloat x = kIMG_Space + i * (kIMG_Space * 2 + w);
            
            LYLIMGBrowse *img_scr = [[LYLIMGBrowse alloc]initWithFrame:CGRectMake(x, y, w, h) imgURL:imgs[i] img:nil];
            
            img_scr.LYL_delegate = self;
            [self addSubview:img_scr];
            
        }
        
        
        self.contentSize = CGSizeMake(self.subviews.count * self.frame.size.width, kWindow.Sh);
        
        self.contentOffset = CGPointMake(page_number * self.frame.size.width, 0);
        
        self.pageControl.numberOfPages = imgs.count;
        self.pageControl.currentPage = page_number;
        
    }
    return self;
}

#pragma mark -  LYLIMGBrowseDelegate
-(void)singleTappedImageViewAction:(id)sender
{
    [self.pageControl removeFromSuperview];
    if (self.LYLScrDelegate && [self.LYLScrDelegate respondsToSelector:@selector(touchedImageViewAction:)]) {
        
        [self.LYLScrDelegate touchedImageViewAction:self];
    }
    
}
-(void)doubleTappedImageViewAction:(id)sender withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    LYLIMGBrowse * browse = sender;
    CGPoint touchPoint = [touch locationInView:browse];
    
    
    CGFloat offsetX = 0.0f;
    CGFloat offsetY = (browse.bounds.size.height > browse.contentSize.height)?(browse.bounds.size.height - browse.contentSize.height)/2 : 0.0;
    
    if (browse.zoomScale != 1) {
        [browse setZoomScale:1 animated:YES];
    } else {

        [browse zoomToRect:CGRectMake(((touchPoint.x-offsetX)/1), ((touchPoint.y-offsetY)/1), 1, 1) animated:YES];
    }

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint set = scrollView.contentOffset;
    self.pageControl.currentPage = set.x / kWindow.Sw;
    
    for (UIView *scr in scrollView.subviews) {
        
        if ([scr isKindOfClass:[UIScrollView class]]) {
            UIScrollView *temp = (UIScrollView *)scr;
            temp.zoomScale = 1;
        }
    }
    
}

-(LYLPageControl *)pageControl{
    if (!_pageControl) {
        
        
        _pageControl = [[LYLPageControl alloc]initWithFrame:CGRectMake(0, 0, kWindow.Sw, 20)];
        _pageControl.center = CGPointMake(kWindow.Sw / 2, kWindow.Sh - 20);
        
//        _pageControl.pageIndicatorTintColor = kThemeColor;
//        _pageControl.currentPageIndicatorTintColor = kThemeColor;
        [_pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
//        [kWindow addSubview:_pageControl];
    }
    return _pageControl;
}
-(void)pageControlAction:(UIPageControl*)pageControl
{
    self.contentOffset = CGPointMake(self.frame.size.width * pageControl.currentPage, 0);
    self.pageControl.currentPage = pageControl.currentPage;
}

- (void)changeFrame:(NSNotification *)noti {
    NSMutableArray *img_scrs = [NSMutableArray array];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LYLIMGBrowse class]]) {
            [img_scrs addObject:obj];
        }
    }];
    CGRect rect = kWindow.bounds;
    rect.size.width += kIMG_Space * 2;
    self.bounds = rect;
    self.center = CGPointMake(kWindow.Sw *0.5, kWindow.Sh *0.5);
    
    CGFloat y = 0;
    __block CGFloat w = kWindow.Sw;
    CGFloat h = kWindow.Sh;
    
    for (int i = 0; i < img_scrs.count; i++) {
        
        CGFloat x = kIMG_Space + i * (kIMG_Space * 2 + w);
        
        LYLIMGBrowse *img_scr = img_scrs[i];
        img_scr.frame = CGRectMake(x, y, w, h);
    }
    
    self.contentSize = CGSizeMake(self.subviews.count * self.frame.size.width, kWindow.Sh);
    self.contentOffset = CGPointMake(self.pageControl.currentPage * self.frame.size.width, 0);
    self.pageControl.frame = CGRectMake(0, 0, kWindow.Sw, 20);
    self.pageControl.center = CGPointMake(kWindow.Sw / 2, kWindow.Sh - 20);
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self];
}

@end
