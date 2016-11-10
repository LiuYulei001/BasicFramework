//
//  UIImageView+GIF.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/8.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UIImageView+GIF.h"
#import <ImageIO/ImageIO.h>
#import <objc/runtime.h>

#if __has_feature(objc_arc)
#define toCF (__bridge CFTypeRef)
#define ARCCompatibleAutorelease(object) object
#else
#define toCF (CFTypeRef)
#define ARCCompatibleAutorelease(object) [object autorelease]
#endif

@implementation UIImageView (GIF)

- (void)animatedGIFImageSource:(CGImageSourceRef) source
                   andDuration:(NSTimeInterval) duration {
    
    
    if (!source) return;
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    for (size_t i = 0; i < count; ++i) {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!cgImage)
            return;
        [images addObject:[UIImage imageWithCGImage:cgImage]];
        CGImageRelease(cgImage);
    }
    self.image_array = images;
    [self setAnimationImages:images];
    [self setAnimationDuration:duration];
    [self startAnimating];
}

- (NSTimeInterval)durationForGifData:(NSData *)data {
    char graphicControlExtensionStartBytes[] = {0x21,0xF9,0x04};
    double duration=0;
    NSRange dataSearchLeftRange = NSMakeRange(0, data.length);
    while(YES){
        NSRange frameDescriptorRange = [data rangeOfData:[NSData dataWithBytes:graphicControlExtensionStartBytes length:3] options:NSDataSearchBackwards range:dataSearchLeftRange];
        
        if(frameDescriptorRange.location!=NSNotFound){
            NSData *durationData = [data subdataWithRange:NSMakeRange(frameDescriptorRange.location+4, 2)];
            unsigned char buffer[2];
            [durationData getBytes:buffer];
            double delay = (buffer[0] | buffer[1] << 8);
            duration += delay;
            dataSearchLeftRange = NSMakeRange(0, frameDescriptorRange.location);
        }else{
            break;
        }
    }
    return duration/100;
}

- (void)showGifImageWithData:(NSData *)data {
    NSTimeInterval duration = [self durationForGifData:data];
    CGImageSourceRef source = CGImageSourceCreateWithData(toCF data, NULL);
    [self animatedGIFImageSource:source andDuration:duration];
    CFRelease(source);
}

- (void)showGifImageWithURL:(NSURL *)url {
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self showGifImageWithData:data];
}
// 在分类里添加属性
static char AddressKey;

-(void)setImage_array:(NSArray *)image_array
{
    objc_setAssociatedObject(self, &AddressKey, image_array, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSArray *)image_array
{
    return objc_getAssociatedObject(self, &AddressKey);
}
@end
