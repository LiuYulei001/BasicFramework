//

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
