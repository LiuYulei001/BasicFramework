//
//  LYLBouncing.m
//  LYLAlertView
//
//  Created by Rainy on 2017/2/8.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "LYLBouncing.h"

@implementation LYLBouncing

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initSuccessCircleWithFrame:(CGRect)frame AlertType:(AlertType)type Color:(UIColor*) color
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setCornerRadius:frame.size.width/2];
        self.layer.masksToBounds = YES;
        // Initialization code
        if (color)
        {
            self.backgroundColor = color;
        }
        else
        {
            switch (type) {
                case AlertSuccess:
                    self.backgroundColor = GREENCOLOR;
                    break;
                case AlertFailure:
                    self.backgroundColor = REDCOLOR;
                    break;
                case AlertInfo:
                    self.backgroundColor = BLUECOLOR;
                    break;
                default:
                    break;
            }
        }
        
    }
    return self;
}

@end
