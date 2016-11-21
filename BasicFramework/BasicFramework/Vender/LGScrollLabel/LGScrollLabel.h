//
//  LGScrollLabel.h
//  LGScrollLabelDemo
//
//  Created by apple on 15/3/16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    LGScrollLabelDirectionLTR,
    LGScrollLabelDirectionRTL,
} LGScrollLabelDirection;

@interface LGScrollLabel : UIView

//是否正在滚动
@property(nonatomic, readonly, assign) BOOL running;
//字体
@property(nonatomic, retain) UIFont * textFont;
//字体颜色
@property(nonatomic, retain) UIColor * textColor;
//当前内容标记
@property(nonatomic, readonly, assign) NSInteger currentIndex;

//显示内容
@property(nonatomic, retain) NSArray *strings;
//滚动速度
@property(nonatomic, assign) float speed;
//是否循环
@property(nonatomic, assign) BOOL loops;
//滚动方向
@property(nonatomic, assign) LGScrollLabelDirection direction;

-(void)start;
//-(void)stop;
-(void)pause;
-(void)resume;

@end
