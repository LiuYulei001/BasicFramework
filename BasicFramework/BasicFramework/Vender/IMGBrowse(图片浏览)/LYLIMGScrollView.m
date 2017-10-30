

#define kIMG_Space 10

#import "LYLIMGScrollView.h"
#import "LYLIMGBrowse.h"

@interface LYLIMGScrollView ()<UIScrollViewDelegate,LYLIMGBrowseDelegate>



@end



@implementation LYLIMGScrollView



-(instancetype)initWithFrame:(CGRect)frame imgs:(NSArray *)imgs withIndexPage:(NSInteger)page_number
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pagingEnabled = YES;
        self.bounces = YES;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        CGRect rect = self.bounds;
        self.Sw += kIMG_Space * 2;
        self.X -= kIMG_Space;
        __block CGFloat w = rect.size.width;
     
        for (int i = 0; i < imgs.count; i++) {
            
            CGFloat x = kIMG_Space + i * (kIMG_Space * 2 + w);
            
            LYLIMGBrowse *img_scr = [[LYLIMGBrowse alloc]initWithFrame:CGRectMake(x, 0, w, self.Sh) imgURL:nil img:imgs[i]];
            
            img_scr.LYL_delegate = self;
            [self addSubview:img_scr];

            
        }

        self.contentSize = CGSizeMake(self.subviews.count * self.frame.size.width, self.Sh);
        
        self.contentOffset = CGPointMake(page_number * self.frame.size.width, 0);
        
        self.pageControl.numberOfPages = imgs.count;
        self.pageControl.currentPage = page_number;
        
    }

    return self;

}
-(instancetype)initWithFrame:(CGRect)frame imgURLs:(NSArray *)imgs withIndexPage:(NSInteger)page_number
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pagingEnabled = YES;
        self.bounces = YES;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        
        CGRect rect = self.bounds;
        self.Sw += kIMG_Space * 2;
        self.X -= kIMG_Space;
        __block CGFloat w = rect.size.width;
        
        
        for (int i = 0; i < imgs.count; i++) {
            
            CGFloat x = kIMG_Space + i * (kIMG_Space * 2 + w);
            
            LYLIMGBrowse *img_scr = [[LYLIMGBrowse alloc]initWithFrame:CGRectMake(x, 0, w, self.Sh) imgURL:imgs[i] img:nil];
            
            img_scr.LYL_delegate = self;
            [self addSubview:img_scr];
            
        }
        
        
        self.contentSize = CGSizeMake(self.subviews.count * self.frame.size.width, self.Sh);
        
        self.contentOffset = CGPointMake(page_number * self.frame.size.width, 0);
        
        self.pageControl.numberOfPages = imgs.count;
        self.pageControl.currentPage = page_number;
        
    }
    return self;
}

#pragma mark -  LYLIMGBrowseDelegate
-(void)singleTappedImageViewAction:(id)sender
{
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
    self.pageControl.currentPage = set.x / self.Sw;
    
    for (UIView *scr in scrollView.subviews) {
        
        if ([scr isKindOfClass:[UIScrollView class]]) {
            UIScrollView *temp = (UIScrollView *)scr;
            temp.zoomScale = 1;
        }
    }
    
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        
        
        _pageControl = [[UIPageControl alloc]init];
        
        _pageControl.pageIndicatorTintColor = kPageDefaultColor;
        _pageControl.currentPageIndicatorTintColor = ThemeColor;
        [_pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}
-(void)pageControlAction:(UIPageControl*)pageControl
{
    self.contentOffset = CGPointMake(self.frame.size.width * pageControl.currentPage, 0);
    self.pageControl.currentPage = pageControl.currentPage;
}


@end
