//
//  LYLPageControl.m
//  SPI-Piles
//
//  Created by SPI-绿能宝 on 16/5/16.
//  Copyright © 2016年 北京SPI绿能宝. All rights reserved.
//

#import "LYLPageControl.h"

@interface LYLPageControl ()
{
    
    UIImage* activeImage;
    
    UIImage* inactiveImage;
    
}

@end

@implementation LYLPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id) initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    
//    activeImage = [UIImage imageNamed:@"RedPoint.png"];
//    
//    inactiveImage = [UIImage imageNamed:@"BluePoint.png"];
    
    
    return self;
    
}


-(void) updateDots

{
    for (int i=0; i<[self.subviews count]; i++) {
        
        UIImageView* dot = [self.subviews objectAtIndex:i];
                
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, 8, 8)];
        
        if (i==self.currentPage)
        {
            
            dot.backgroundColor = [UIColor whiteColor];
            dot.cornerRad = 4;
            
        }else
        {

            dot.backgroundColor = [UIColor clearColor];

            dot.layer.borderWidth = 2;
            dot.cornerRad = 4;
            dot.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        
    }
    
}

-(void) setCurrentPage:(NSInteger)page

{
    
    [super setCurrentPage:page];
    
    [self updateDots];
    
}

@end
