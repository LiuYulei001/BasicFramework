
//

#import "LYLIMGBrowse.h"
#import "MBProgressHUD.h"

@interface LYLIMGBrowse ()<UIScrollViewDelegate>
{
    UIImage *_img_temp;
}


@end

static NSString * const DefaultImage = @"zhaopian";
@implementation LYLIMGBrowse

-(instancetype)initWithFrame:(CGRect)frame imgURL:(NSString *)img_url img:(UIImage *)img
{
    self = [super initWithFrame:frame];
    if (self) {
 
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        self.bouncesZoom = YES;
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 5.0;
        
        UIImageView *img_v = [[UIImageView alloc]init];
        img_v.contentMode = UIViewContentModeScaleAspectFit;
        img_v.frame = self.bounds;
        
        if (img == nil) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:img_v animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"0%";
            
            __weak UIImageView *IMG = img_v;
            
            [img_v sd_setImageWithURL:[NSURL URLWithString:img_url] placeholderImage:[UIImage imageNamed: DefaultImage] options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
                
                if (expectedSize >= 0) {
                    
                    hud.labelText = [NSString stringWithFormat:@"%.0f%%",receivedSize / (expectedSize * 1.0) * 100];
                    
                }
                
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                
                if (!error) {
                    
                    [hud hide:YES];
                    
                    IMG.contentMode = UIViewContentModeScaleAspectFill;
                    
                    IMG.image = image;
                    _img_temp = image;
                    
                    float scaleX = self.Sw / image.size.width;
                    float scaleY = self.Sh / image.size.height;
                    
                    if (scaleX > scaleY) {
                        
                        float imgViewWidth = scaleY*image.size.width;
                        
                        IMG.frame = (CGRect){self.Sw/2 - imgViewWidth/2,0,imgViewWidth,self.Sh};
                        
                    }else{
                        
                        float imgViewHeight = scaleX*image.size.height;
                        IMG.frame = (CGRect){0,self.Sh/2 - imgViewHeight/2,self.Sw,imgViewHeight};
                        
                    }
                    
                }else
                {
                    hud.labelText = @"加载失败";
                    _img_temp = nil;
                }
                
                
            }];
        }else
        {
            img_v.contentMode = UIViewContentModeScaleAspectFit;
            
            img_v.image = img;
            _img_temp = img;
            
            float scaleX = self.Sw / img.size.width;
            float scaleY = self.Sh /img.size.height;
            
            if (scaleX > scaleY) {
                
                float imgViewWidth = scaleY*img.size.width;
                
                img_v.frame = (CGRect){self.Sw/2 - imgViewWidth/2,0,imgViewWidth,self.Sh};
                
            }else{
                
                float imgViewHeight = scaleX*img.size.height;
                img_v.frame = (CGRect){0,self.Sh/2 - imgViewHeight/2,self.Sw,imgViewHeight};
                
            }

        }
        
        [self addSubview:img_v];
        }
    
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch * touch = [[event allTouches] anyObject];
    NSTimeInterval delayTime = 0.2;
    switch ([touch tapCount]) {
        case 1:
            
            [self performSelector:@selector(singleTap) withObject:nil afterDelay:delayTime];
            break;
        case 2:{
            
            if (_img_temp) {
                
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
                [self performSelector:@selector(doubleTap:) withObject:event afterDelay:delayTime];
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark ----scrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (_img_temp) {
        
        return scrollView.subviews[0];
    }
    return nil;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize boundSize = CGSizeMake(self.Sw, self.Sh);
    CGSize contentSize = scrollView.contentSize;
    CGRect imageFrame = scrollView.subviews[0].frame;
    
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    if (imageFrame.size.width <= boundSize.width) {
        centerPoint.x = boundSize.width/2;
    }
    if (imageFrame.size.height <= boundSize.height) {
        centerPoint.y = boundSize.height/2;
    }
    
    scrollView.subviews[0].center = centerPoint;
    
    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    CGFloat zs = scrollView.zoomScale;
    zs = MAX(zs, 0.5);
    zs = MIN(zs, 5.0);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    scrollView.zoomScale = zs;
    [UIView commitAnimations];
}
- (void)singleTap
{
    if ([self.LYL_delegate respondsToSelector:@selector(singleTappedImageViewAction:)]) {
        [self.LYL_delegate singleTappedImageViewAction:self];
    }
    
}
- (void)doubleTap:(UIEvent *)event
{
    if ([self.LYL_delegate respondsToSelector:@selector(doubleTappedImageViewAction:withEvent:)]) {
        [self.LYL_delegate doubleTappedImageViewAction:self withEvent:event];
    }
    
}


@end
