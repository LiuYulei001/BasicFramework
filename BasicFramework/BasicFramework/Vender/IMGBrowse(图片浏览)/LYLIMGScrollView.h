//

//

#import <UIKit/UIKit.h>

@protocol LYLIMGScrollViewDelegate <NSObject>

- (void)touchedImageViewAction:(id)sender;

@end
@class LYLPageControl;
@interface LYLIMGScrollView : UIScrollView

@property(nonatomic,weak)id<LYLIMGScrollViewDelegate> LYLScrDelegate;

@property(nonatomic,strong)UIPageControl *pageControl;

-(instancetype)initWithFrame:(CGRect)frame
                     imgURLs:(NSArray *)imgs
               withIndexPage:(NSInteger)page_number;

-(instancetype)initWithFrame:(CGRect)frame
                        imgs:(NSArray *)imgs
               withIndexPage:(NSInteger)page_number;


@end
