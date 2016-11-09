//
//  NSString+Extension.h
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

#pragma mark - string of size
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font andMaxW:(CGFloat)maxW;
#pragma mark - nil NULL "space"
+ (BOOL)isBlankString:(NSString *)string;
#pragma md5
- (NSString *)MD5string;
/**
 *  字符串添加图片
 */
-(NSMutableAttributedString *)insertImg:(UIImage *)Img atIndex:(NSInteger )index IMGrect:(CGRect )IMGrect;
/**
 *  不同颜色不同字体大小字符串
 */
-(NSMutableAttributedString *)setOtherColor:(UIColor *)Color font:(CGFloat)font forStr:(NSString *)forStr;

- (BOOL)isChinese;
- (NSString *)pinyin;
- (NSString *)pinyinInitial;

- (BOOL)isEmail;
- (BOOL)isPhoneNumber;
- (BOOL)isDigit;
- (BOOL)isNumeric;
- (BOOL)isUrl;
- (BOOL)isMinLength:(NSUInteger)length;
- (BOOL)isMaxLength:(NSUInteger)length;
- (BOOL)isMinLength:(NSUInteger)min andMaxLength:(NSUInteger)max;
- (BOOL)isEmpty;

@end
