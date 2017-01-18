//
//  BaseTabBar.m
//  BasicFramework
//
//  Created by Rainy on 16/8/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#define middleBT_Normal_IMG @"post_normal"
#define middleBT_Highlighted_IMG @"post_normal"
#define middleBT_Disabled_IMG @"post_normal"

#define middleLab_Title @"发布"
#define middleLab_Font ElevenFontSize

#define Selected_textColor ThemeColor
#define Normal_textColor kNormalFontColor

#import "BaseTabBar.h"

#define LBMagin 5

@interface BaseTabBar ()

@property (nonatomic, strong) UIButton *middle_BT;
@property (nonatomic, strong) UILabel *middle_Lable;

@end

@implementation BaseTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];
        [self setShadowImage:[UIImage createImageWithColor:[UIColor clearColor]]];
        [self addSubview:self.middle_BT];
    }
    return self;
}
#pragma mark - setPoint
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.middle_BT.X = ([UIScreen mainScreen].bounds.size.width - self.middle_BT.currentBackgroundImage.size.width) * 0.5;
    self.middle_BT.size = CGSizeMake(self.middle_BT.currentBackgroundImage.size.width, self.middle_BT.currentBackgroundImage.size.height);

    self.middle_Lable.Cx = self.middle_BT.Cx;
    _middle_Lable.Y = self.Sh - _middle_Lable.Sh - 1;

    self.middle_BT.Y = _middle_Lable.Y - self.middle_BT.Sh - LBMagin;

    Class class = NSClassFromString(@"UITabBarButton");
    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:class]) {
            
            btn.Sw = self.Sw / (self.items.count + 1);

            btn.X = btn.Sw * btnIndex;

            btnIndex++;
            
            if (btnIndex == 2) {
                btnIndex++;
            }
            
        }
    }
    
    [self bringSubviewToFront:self.middle_BT];
}
- (void)middle_BTDidClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarMiddle_BTClick:)]) {
        [self.myDelegate tabBarMiddle_BTClick:self];
    }

}
#pragma mark - 重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {

        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.middle_BT];

        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.middle_BT pointInside:newP withEvent:event]) {
            return self.middle_BT;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了

            return [super hitTest:point withEvent:event];
        }
    }

    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}
#pragma mark - lazy
-(UIButton *)middle_BT
{
    if (!_middle_BT) {
        
        _middle_BT = [UIButton buttonWithType:UIButtonTypeSystem];
        [_middle_BT setBackgroundImage:[UIImage imageNamed:middleBT_Normal_IMG] forState:UIControlStateNormal];
        [_middle_BT setBackgroundImage:[UIImage imageNamed:middleBT_Highlighted_IMG] forState:UIControlStateHighlighted];
        [_middle_BT setBackgroundImage:[UIImage imageNamed:middleBT_Disabled_IMG] forState:UIControlStateDisabled];
        [_middle_BT addTarget:self action:@selector(middle_BTDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _middle_BT;
}
-(UILabel *)middle_Lable
{
    if (!_middle_Lable) {
        
        _middle_Lable = [[UILabel alloc] init];
        _middle_Lable.text = middleLab_Title;
        _middle_Lable.font = middleLab_Font;
        [_middle_Lable sizeToFit];
        _middle_Lable.textColor = Normal_textColor;
        [self addSubview:_middle_Lable];
    }
    return _middle_Lable;
}
@end
