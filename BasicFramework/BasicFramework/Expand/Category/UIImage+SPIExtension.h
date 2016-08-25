//
//

#import <UIKit/UIKit.h>

@interface UIImage (SPIExtension)

#pragma mark take image to this size
-(UIImage*)scaleToSize:(CGSize)size;
#pragma mark restore image to befor
-(UIImage *)restoreMyimage;
#pragma mark color -> image
+ (UIImage *)createImageWithColor:(UIColor*)color;
#pragma mark image -> color
- (UIImage *)imageWithColor:(UIColor *)color;

@end
