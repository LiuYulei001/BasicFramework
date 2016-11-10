//
//  NSMutableAttributedString+Extension.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/8.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)


-(void)insertImgs:(UIImage *)Img atIndex:(NSInteger )index IMGrect:(CGRect )IMGrect
{
    if (index <= self.length - 1) {
        
        NSTextAttachment *attatchment = [[NSTextAttachment alloc] init];
        attatchment.image = Img;
        attatchment.bounds = IMGrect;
        [self insertAttributedString:[NSAttributedString attributedStringWithAttachment:attatchment] atIndex:index];
    }
}

@end
