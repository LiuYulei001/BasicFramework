//
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
