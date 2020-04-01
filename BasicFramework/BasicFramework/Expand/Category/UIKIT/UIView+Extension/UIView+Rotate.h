//
//  UIView+Rotate.h
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ENUMForDirection) {
    topRotate = 1,
    bottomRotate,
    leftRotate,
    rightRotate,
};

typedef NS_ENUM(NSUInteger, VerticalOrHorizontal) {
    
    X = 1,
    Y,
};


typedef UIView *(^RotateBlock)();

typedef UIView *(^SetRotateBlock)(CGFloat,ENUMForDirection,VerticalOrHorizontal);

typedef void (^FinishedAnima)(BOOL);
typedef UIView *(^RotateAnimationBlock)(NSInteger,FinishedAnima);



@interface UIView (Rotate)<CAAnimationDelegate>


@property (nonatomic,retain) CAKeyframeAnimation *keyAnimation;
@property (nonatomic,copy) FinishedAnima completion;

-(SetRotateBlock)setRotateInfo;

- (RotateBlock)topRotate;
- (RotateBlock)bottomRotate;
- (RotateBlock)leftRotate;
- (RotateBlock)rightRotate;
- (RotateBlock)rotateX;
- (RotateBlock)rotateY;
- (RotateAnimationBlock)animationRotate;

//以X轴为中心3D旋转
-(void)rotated:(CGFloat )Angle;

@end

