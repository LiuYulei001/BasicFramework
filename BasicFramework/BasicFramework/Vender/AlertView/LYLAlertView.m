//
//  LYLAlertView.m
//  LYLAlertView
//
//  Created by Rainy on 2017/2/8.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "LYLAlertView.h"

@implementation LYLAlertView

{
    UIView *alertView;
    LYLBouncing *circleView;
    UIImageView * bg;
    
}

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type
{
    return [self initDropAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color
{
    self = [super init];
    if (self) {
        // Initialization code
        _animationType = DropAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}


- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type
{
    return [self initFadeAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color
{
    self = [super init];
    if (self) {
        // Initialization code
        _animationType = FadeInAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}

// init with completion blocks

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self.completionBlock = completionHandler;
    return [self initDropAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self = [super init];
    if (self) {
        // Initialization code
        self.completionBlock = completionHandler;
        _animationType = DropAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}


- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self.completionBlock = completionHandler;
    return [self initFadeAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self = [super init];
    if (self) {
        // Initialization code
        self.completionBlock = completionHandler;
        _animationType = FadeInAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}


- (void) _initViewWithTitle:(NSString *)title andText:(NSString *)text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType)type andColor:(UIColor*) color
{
    self.frame = [self screenFrame];
    self.opaque = YES;
    self.alpha = 1;
    
    bg = [[UIImageView alloc]initWithFrame:[self screenFrame]];
    
    alertView = [self alertPopupView];
    
    [self labelSetupWithTitle:title andText:text];
    [self buttonSetupForType:type withCancelButton: hasCancelButton andColor:color];
    [self addSubview:alertView];
    
    [self circleSetupForAlertType:type andColor:color];
}





- (void) show
{
    id<LYLAlertViewDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(alertViewWillShow:)]) [delegate alertViewWillShow:self];
    
    switch (_animationType) {
        case DropAnimation:
            [self triggerDropAnimations];
            break;
        case FadeInAnimation:
            [self triggerFadeAnimations];
            break;
            
        default:
            break;
    }
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
}

#pragma mark - Blur

-(void) performScreenshotAndBlur
{
    UIImage * image = [self convertViewToImage];
    [bg setImage:image];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    [bg addSubview:effectView];
    //    bg.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [self addSubview:bg];
}


#pragma mark - Items Setup

- (void) circleSetupForAlertType:(AlertType) type andColor:(UIColor*) color
{
    UIView * circleMask = [[UIView alloc]initWithFrame:CGRectMake([self screenFrame].size.width/2, (([self screenFrame].size.height/2)-alertView.frame.size.height/2) , 60, 60)];
    _logoView = [[UIImageView alloc]initWithFrame:CGRectMake(circleMask.frame.size.width/2-40, circleMask.frame.size.height/2-40 , 20, 20)];
    _logoView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    circleView = [[LYLBouncing alloc]initSuccessCircleWithFrame:CGRectMake(0, 0, 60, 60) AlertType:type Color:color];
    circleView.center = _logoView.center;
    circleView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    switch (type) {
        case AlertSuccess:
            [_logoView setImage:[UIImage imageNamed:@"checkMark.png"]];
            break;
        case AlertFailure:
            [_logoView setImage:[UIImage imageNamed:@"crossMark.png"]];
            break;
        case AlertInfo:
            [_logoView setImage:[UIImage imageNamed:@"info.png"]];
            break;
            
        default:
            break;
    }
    _logoView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:circleMask];
    [circleMask addSubview:circleView];
    [circleMask addSubview:_logoView];
}

- (void) labelSetupWithTitle:(NSString*) title andText:(NSString*) text
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    _titleLabel.center = CGPointMake(alertView.frame.size.width/2, 45);
    _titleLabel.text = title;
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [alertView addSubview:_titleLabel];
    
    
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 50)];
    _textLabel.center = CGPointMake(alertView.frame.size.width/2, 80);
    _textLabel.text = text;
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _textLabel.numberOfLines = 0;
    [alertView addSubview:_textLabel];
    
}

- (void) buttonSetupForType:(AlertType)type withCancelButton:(BOOL) hasCancelButton andColor:(UIColor*) color
{
    
    if (hasCancelButton) {
        //default button
        _defaultButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _defaultButton.frame = CGRectMake(0, 0, 84, 30);
        _defaultButton.center = CGPointMake((alertView.frame.size.width/4)+3, 120);
        
        //cancel button
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.frame = CGRectMake(0, 0, 84, 30);
        _cancelButton.center = CGPointMake((alertView.frame.size.width*3/4)-3, 120);
        _cancelButton.backgroundColor = [UIColor colorWithRed:0.792 green:0.792 blue:0.792 alpha:1];
        
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton.layer setCornerRadius:3.0f];
    }else{
        _defaultButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _defaultButton.frame = CGRectMake(0, 0, 180, 30);
        _defaultButton.center = CGPointMake(alertView.frame.size.width/2, 120);
    }
    
    [self setColorForButton:color onButton:_defaultButton withType:type];
    
    //default button end setup
    [_defaultButton setTitle:@"确定" forState:UIControlStateNormal];
    _defaultButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_defaultButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_defaultButton.layer setCornerRadius:3.0f];
    [_defaultButton  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [alertView addSubview:_defaultButton];
    if (hasCancelButton)[alertView addSubview:_cancelButton];
    
}






#pragma mark - Animations

-(void) triggerDropAnimations
{
    
    NSMutableArray* animationBlocks = [NSMutableArray new];
    
    typedef void(^animationBlock)(BOOL);
    
    // getNextAnimation
    // removes the first block in the queue and returns it
    animationBlock (^getNextAnimation)() = ^{
        animationBlock block = animationBlocks.count ? (animationBlock)[animationBlocks objectAtIndex:0] : nil;
        if (block){
            [animationBlocks removeObjectAtIndex:0];
            return block;
        }else{
            return ^(BOOL finished){};
        }
    };
    
    //block 1
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            bg.alpha = 1.0;
        } completion: getNextAnimation()];
    }];
    
    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2)+alertView.frame.size.height*0.1);
        } completion: getNextAnimation()];
    }];
    
    //block 3
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2));
        } completion: getNextAnimation()];
    }];
    
    //add a block to our queue
    [animationBlocks addObject:^(BOOL finished){;
        [self circleAnimation];
    }];
    
    // execute the first block in the queue
    getNextAnimation()(YES);
}



-(void) triggerFadeAnimations
{
    
    alertView.alpha = 0;
    alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2));
    
    NSMutableArray* animationBlocks = [NSMutableArray new];
    
    typedef void(^animationBlock)(BOOL);
    
    // getNextAnimation
    // removes the first block in the queue and returns it
    animationBlock (^getNextAnimation)() = ^{
        animationBlock block = animationBlocks.count ? (animationBlock)[animationBlocks objectAtIndex:0] : nil;
        if (block){
            [animationBlocks removeObjectAtIndex:0];
            return block;
        }else{
            return ^(BOOL finished){};
        }
    };
    
    //block 1
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            bg.alpha = 1.0;
        } completion: getNextAnimation()];
    }];
    
    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            alertView.alpha = 1;
        } completion: getNextAnimation()];
    }];
    
    //add a block to our queue
    [animationBlocks addObject:^(BOOL finished){;
        [self circleAnimation];
    }];
    
    // execute the first block in the queue
    getNextAnimation()(YES);
    
}

- (void) circleAnimation
{
    NSMutableArray* animationBlocks = [NSMutableArray new];
    
    typedef void(^animationBlock)(BOOL);
    
    // getNextAnimation
    // removes the first block in the queue and returns it
    animationBlock (^getNextAnimation)() = ^{
        animationBlock block = animationBlocks.count ? (animationBlock)[animationBlocks objectAtIndex:0] : nil;
        if (block){
            [animationBlocks removeObjectAtIndex:0];
            return block;
        }else{
            return ^(BOOL finished){};
        }
    };
    
    //block 1
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.08 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //            circleView.frame = [circleView newFrameWithWidth:85 andHeight:85];
            circleView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            _logoView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion: getNextAnimation()];
    }];
    
    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.08 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            circleView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            _logoView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion: getNextAnimation()];
    }];
    
    //block 3
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.08 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            circleView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            _logoView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion: getNextAnimation()];
    }];
    
    //add a block to our queue
    [animationBlocks addObject:^(BOOL finished){;
        self.isDisplayed = true;
        id<LYLAlertViewDelegate> delegate = self.delegate;
        if ([delegate respondsToSelector:@selector(alertViewDidShow:)]) [delegate alertViewDidShow:self];
    }];
    
    // execute the first block in the queue
    getNextAnimation()(YES);
}



#pragma mark - set
- (UIView*) alertPopupView
{
    UIView * alertSquare = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 150)];
    
    alertSquare.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1];
    alertSquare.center = CGPointMake([self screenFrame].size.width/2, -[self screenFrame].size.height/2);
    
    [alertSquare.layer setShadowColor:[UIColor blackColor].CGColor];
    [alertSquare.layer setShadowOpacity:0.4];
    [alertSquare.layer setShadowRadius:20.0f];
    [alertSquare.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    [self performScreenshotAndBlur];
    
    return alertSquare;
}
- (void) setColorForButton:(UIColor*) color onButton:(UIButton*) btn withType:(AlertType)type
{
    if (color)
    {
        btn.backgroundColor = color;
    }
    else
    {
        switch (type) {
            case AlertSuccess:
                btn.backgroundColor = GREENCOLOR;
                break;
            case AlertFailure:
                btn.backgroundColor = REDCOLOR;
                break;
            case AlertInfo:
                btn.backgroundColor = BLUECOLOR;
                break;
                
            default:
                break;
        }
    }
    
}
- (void) setTitleFont:(UIFont *)titleFont
{
    [_titleLabel setFont:titleFont];
}

- (void) setTextFont:(UIFont *)textFont
{
    [_textLabel setFont:textFont];
}

-(void) setTitleText:(NSString*) string
{
    _titleLabel.text = string;
}

-(void) setMessageText:(NSString*) string
{
    _textLabel.text = string;
}
#pragma mark other
- (void) setCornerRadius:(float)cornerRadius
{
    [alertView.layer setCornerRadius:cornerRadius];
}
- (CGRect) screenFrame
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect;
}



-(UIImage *)convertViewToImage
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedScreen;
}


- (void) dismissAlertView
{
    id<LYLAlertViewDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(alertViewWillDismiss:)]) [delegate alertViewWillDismiss:self];
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         self.isDisplayed = false;
                         if ([delegate respondsToSelector:@selector(alertViewDidDismiss:)]) [delegate alertViewDidDismiss:self];
                     }];
}
#pragma mark - Delegate Methods
- (void)handleButtonTouched:(id)sender {
    [self dismissAlertView];
    
    id<LYLAlertViewDelegate> delegate = self.delegate;
    UIButton *button = (UIButton *) sender;
    if ([delegate respondsToSelector:@selector(alertView:didDismissWithButton:)]) {
        // Since there isn't a button index for the alertView, pass the button
        [delegate alertView:self didDismissWithButton:button];
    }
    
    if(self.completionBlock) {
        self.completionBlock(self, button);
    }
}


@end
