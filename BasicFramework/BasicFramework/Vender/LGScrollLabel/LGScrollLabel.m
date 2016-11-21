//
//  LGScrollLabel.m
//  LGScrollLabelDemo
//
//  Created by apple on 15/3/16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LGScrollLabel.h"

@interface LGScrollLabel ()

//scrollLabel
@property(nonatomic, retain) UILabel * textLabel;

@end

@implementation LGScrollLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    //设置背景色
    [self setBackgroundColor:[UIColor clearColor]];
    
    //其他设置
    //    [self.layer setCornerRadius:5.0f];
    //    [self.layer setBorderWidth:2.0f];
    //    [self.layer setBorderColor:[UIColor blackColor].CGColor];
    [self setClipsToBounds:YES];//超出范围不显示
    
    //设置textLabel
    //    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 4, self.frame.size.width, self.frame.size.height)];
    self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [self.textLabel setBackgroundColor:[UIColor clearColor]];
    [self.textLabel setNumberOfLines:1];
    [self addSubview:self.textLabel];
    
    //设置默认字体与大小
    self.textFont = [UIFont systemFontOfSize:20];
    self.textColor = [UIColor blueColor];
    
    //设置默认循环
    self.loops = YES;
    
    //设置默认从右到左滚动
    self.direction = LGScrollLabelDirectionRTL;
}

-(void)animateCurrentScrollString
{
    //获取当前文本
    NSString *currentString = [self.strings objectAtIndex:self.currentIndex];
    
    //计算文本大小
    CGSize textSize = [currentString boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics) attributes:@{NSFontAttributeName:self.textFont} context:nil].size;
    
    //计算开始位置和结束位置
    float startingX = 0.0f;
    float endX = 0.0f;
    switch (self.direction) {
        case LGScrollLabelDirectionLTR:
            startingX = -textSize.width;
            endX = self.frame.size.width;
            break;
        case LGScrollLabelDirectionRTL:
        default:
            startingX = self.frame.size.width;
            endX = -textSize.width;
            break;
    }
    
    //设置textLabel位置
    //    [self.textLabel setFrame:CGRectMake(startingX, self.textLabel.frame.origin.y, textSize.width, textSize.height)];
    [self.textLabel setFrame:CGRectMake(startingX, 0, textSize.width, textSize.height)];
    
    //显示文本
    [self.textLabel setText:currentString];
    
    //计算滚动时间
    float duration = (textSize.width + self.frame.size.width) / self.speed;
    
    //创建动画
    [UIView beginAnimations:@"scrollLabel" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(scrollLabelMoveAnimationDidStop:finished:context:)];
    
    //
    CGRect labelFrame = self.textLabel.frame;
    labelFrame.origin.x = endX;
    [self.textLabel setFrame:labelFrame];
    
    [UIView commitAnimations];
}

-(void)scrollLabelMoveAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    //更新当前文本下标
    _currentIndex++;
    
    if(self.currentIndex >= [self.strings count]) {
        _currentIndex = 0;
        
        //检查是否需要滚动
        if(!self.loops) {
            _running = NO;
            return;
        }
    }
    
    //开始动画
    [self animateCurrentScrollString];
}

#pragma mark - scrollLabel Animation Handling
-(void)start {
    
    //默认从下标为0的文本开始动画
    _currentIndex = 0;
    
    _running = YES;
    
    [self animateCurrentScrollString];
}

-(void)pause {
    
    //检查是否正在运行
    if(self.running) {
        //暂停layer层动画
        [self pauseLayer:self.layer];
        
        _running = NO;
    }
}

-(void)resume {
    
    //检查是否是在运行
    if(!self.running) {
        //恢复layer层动画
        [self resumeLayer:self.layer];
        
        _running = YES;
    }
}

#pragma mark - UIView layer animations
-(void)pauseLayer:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    self.textLabel.font = textFont;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textLabel.textColor = textColor;
}
@end
