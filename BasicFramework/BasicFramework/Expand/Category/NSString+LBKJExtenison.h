//
//  NSString+LBKJExtenison.h
// 
//
//

#import <Foundation/Foundation.h>

@interface NSString (LBKJExtenison)

- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font andMaxW:(CGFloat)maxW;

+ (BOOL)isBlankString:(NSString *)string;

@end
