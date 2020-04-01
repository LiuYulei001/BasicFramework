//
//  UIView+Rotate.m
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UIView+Rotate.h"
#import <objc/runtime.h>

@implementation UIView (Rotate)
static char keyAnimationKey = 's';
static char completionKey = 'n';
- (void)setKeyAnimation:(CAKeyframeAnimation *)keyAnimation{
    objc_setAssociatedObject(self, &keyAnimationKey, keyAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAKeyframeAnimation *)keyAnimation{
    return objc_getAssociatedObject(self, &keyAnimationKey);
}

- (void)setCompletion:(FinishedAnima)completion{
    objc_setAssociatedObject(self, &completionKey, completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (FinishedAnima)completion{
    return objc_getAssociatedObject(self, &completionKey);
}

-(SetRotateBlock)setRotateInfo
{
    return ^(CGFloat rotateAngle,ENUMForDirection Direction,VerticalOrHorizontal FixedAxis){
        
        switch (Direction) {
            case topRotate:{
                
                [self setAnchorPoint:CGPointMake(0.5, 0)];//设置锚点
                CATransform3D transform = CATransform3DIdentity;
                CATransform3D rotate;
                rotate = CATransform3DMakeRotation(rotateAngle, 1, 0, 0); //控制旋转角度和以什么轴旋转,你想绕哪个轴哪个轴就为1 ,上1，下-1，左-1，右1
                transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 2000); //透视，轻微旋转了Z轴
                [self.layer setTransform:transform];//初始的view旋转完毕
                return self;
            }
                
                break;
            case bottomRotate:{
                
                [self setAnchorPoint:CGPointMake(0.5, 1)];
                CATransform3D transform = CATransform3DIdentity;
                CATransform3D rotate;
                rotate = CATransform3DMakeRotation(rotateAngle, -1, 0, 0);
                transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 2000);
                [self.layer setTransform:transform];
                return self;
                
                
            }
                
                break;
            case leftRotate:{
                
                [self setAnchorPoint:CGPointMake(0, 0.5)];
                CATransform3D transform = CATransform3DIdentity;
                CATransform3D rotate;
                rotate = CATransform3DMakeRotation(rotateAngle, 0, -1, 0);
                transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 4000);
                [self.layer setTransform:transform];
                return self;
                
            }
                
                break;
            case rightRotate:{
                
                [self setAnchorPoint:CGPointMake(1, 0.5)];
                CATransform3D transform = CATransform3DIdentity;
                CATransform3D rotate;
                rotate = CATransform3DMakeRotation(rotateAngle, 0, 1, 0);
                transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 2000);
                [self.layer setTransform:transform];
                return self;
                
            }
                
                break;
                
            default:
                break;
        }
        
        
        switch (FixedAxis) {
            case X:{
                CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
                keyAnima.keyPath=@"transform.rotation.x";
                self.keyAnimation = keyAnima;
                return self;
            }
                
                break;
            case Y:{
                
                CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
                keyAnima.keyPath=@"transform.rotation.y";
                self.keyAnimation = keyAnima;
                return self;
                
            }
                
                break;
                
            default:
                break;
        }
        
        
    };
}


- (RotateBlock)topRotate{
    return ^(){
        [self setAnchorPoint:CGPointMake(0.5, 0)];//设置锚点
        CATransform3D transform = CATransform3DIdentity;
        CATransform3D rotate;
        rotate = CATransform3DMakeRotation(-M_PI/4, 1, 0, 0); //控制旋转角度和以什么轴旋转,你想绕哪个轴哪个轴就为1 ,上1，下-1，左-1，右1
        transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 2000); //透视，轻微旋转了Z轴
        [self.layer setTransform:transform];//初始的view旋转完毕
        return self;
    };
    
}
- (RotateBlock)bottomRotate{
    return ^(){
        [self setAnchorPoint:CGPointMake(0.5, 1)];
        CATransform3D transform = CATransform3DIdentity;
        CATransform3D rotate;
        rotate = CATransform3DMakeRotation(-M_PI/4, -1, 0, 0);
        transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 2000);
        [self.layer setTransform:transform];
        return self;
    };
}

- (RotateBlock)rightRotate{
    return ^(){
        [self setAnchorPoint:CGPointMake(1, 0.5)];
        CATransform3D transform = CATransform3DIdentity;
        CATransform3D rotate;
        rotate = CATransform3DMakeRotation(-M_PI/4, 0, 1, 0);
        transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 2000);
        [self.layer setTransform:transform];
        return self;
    };
}

- (RotateBlock)leftRotate{
    return ^(){
        [self setAnchorPoint:CGPointMake(0, 0.5)];
        CATransform3D transform = CATransform3DIdentity;
        CATransform3D rotate;
        rotate = CATransform3DMakeRotation(-M_PI/4, 0, -1, 0);
        transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 4000);
        [self.layer setTransform:transform];
        return self;
    };
}

//帧动画，绕着X轴旋转
- (RotateBlock)rotateX{
    return ^(){
        CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
        keyAnima.keyPath=@"transform.rotation.x";
        self.keyAnimation = keyAnima;
        return self;
    };
}

- (RotateBlock)rotateY{
    return ^(){
        CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
        keyAnima.keyPath=@"transform.rotation.y";
        self.keyAnimation = keyAnima;
        return self;
    };
}

//动画轨迹
- (RotateAnimationBlock)animationRotate{
    return ^(NSInteger time,FinishedAnima completion){
        self.completion = completion;
        NSNumber *num1=[NSNumber numberWithFloat:-M_PI * 0.25];
        NSNumber *num2=[NSNumber numberWithFloat:M_PI * 0.2];
        NSNumber *num3=[NSNumber numberWithFloat:-M_PI * 0.1];
        NSNumber *num4=[NSNumber numberWithFloat:M_PI * 0.05];
        NSNumber *num5=[NSNumber numberWithFloat:-M_PI * 0.025];
        NSNumber *num6=[NSNumber numberWithFloat:M_PI * 0.0];
        NSNumber *time1=[NSNumber numberWithFloat: 0.0];
        NSNumber *time2=[NSNumber numberWithFloat: 0.2];
        NSNumber *time3=[NSNumber numberWithFloat: 0.5];
        NSNumber *time4=[NSNumber numberWithFloat: 0.75];
        NSNumber *time5=[NSNumber numberWithFloat: 0.9];
        NSNumber *time6=[NSNumber numberWithFloat: 1.0];
        self.keyAnimation.values=@[num1,num2,num3,num4,num5,num6];
        self.keyAnimation.keyTimes=@[time1,time2,time3,time4,time5,time6];
        self.keyAnimation.fillMode=kCAFillModeForwards;
        self.keyAnimation.duration = time;
        self.keyAnimation.removedOnCompletion = NO;
        self.keyAnimation.delegate = self;
        self.keyAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.layer addAnimation:self.keyAnimation forKey:@"animateTransform"];
        return  self;
    };
}

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}

- (void)setAnchorPoint:(CGPoint)anchorPoint
{
    CGRect oldFrame = self.frame;
    self.layer.anchorPoint = anchorPoint;
    self.frame = oldFrame;
}

-(void)removeAnimationwithKey: (NSString *)string{
    [self.layer removeAnimationForKey:string];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.completion != nil) {
        self.completion(flag);
    }
    
}

-(void)rotated:(CGFloat )Angle
{
    CALayer *layer = self.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, Angle * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
}



@end
