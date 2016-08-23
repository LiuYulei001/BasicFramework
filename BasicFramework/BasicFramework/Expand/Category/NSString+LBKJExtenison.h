//
//  NSString+LBKJExtenison.h
//  
//
//  Created by ZL on 15/10/21.
//
//

#import <Foundation/Foundation.h>

@interface NSString (LBKJExtenison)

- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font andMaxW:(CGFloat)maxW;

+ (BOOL)isBlankString:(NSString *)string;

@end
