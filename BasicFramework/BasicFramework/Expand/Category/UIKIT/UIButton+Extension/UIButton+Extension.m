//
//  UIButton+Extension.m
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UIButton+Extension.h"
@interface UIImage (MiddleAligning)

@end

@implementation UIImage (MiddleAligning)

- (UIImage *)MiddleAlignedButtonImageScaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end


@implementation UIButton (Extension)
-(dispatch_source_t )startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle finished:(void(^)(UIButton *button))finished
{
    __block NSInteger timeOut = timeout; //The countdown time
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //To perform a second
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){ //it is time to
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //it is time to  set title
                [self setTitle:tittle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                finished(self);
            });
        }else{
            
            NSString *strTime = [NSString stringWithFormat:@"%ld", timeOut];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setTitle:[NSString stringWithFormat:@"%@%@",strTime,waitTittle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            timeOut--;
            
        }
    });
    dispatch_resume(_timer);
    return _timer;
}
-(void)cancelTimer:(dispatch_source_t)timer
{
    if (!timer) return;
    dispatch_source_cancel(timer);
}-(UIImageView *)addImg:(UIImage *)img withIMGframe:(CGRect )IMGframe
{
    UIImageView *img_VC = [[UIImageView alloc]initWithFrame:IMGframe];
    img_VC.image = img;
    img_VC.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:img_VC];
    
    return img_VC;
}
-(void)setFrame:(CGRect)frame Title:(NSString *)title font:(UIFont *)font fontColor:(UIColor *)fontColor State:(UIControlState)state
{
    self.frame = frame;
    [self setTitle:title forState:state];
    [self setTitleColor:fontColor forState:state];
    [self.titleLabel setFont:font];
}

@end
