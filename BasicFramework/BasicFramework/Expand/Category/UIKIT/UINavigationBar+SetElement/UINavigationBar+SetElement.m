//
//  UINavigationBar+SetElement.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/17.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UINavigationBar+SetElement.h"
#import <objc/runtime.h>

static char overlayKey;

@implementation UINavigationBar (SetElement)


- (void)ad_setBackgroundColor:(UIColor *)backgroundColor {
    
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (UIView *)overlay {
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay {
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN);
}

- (void)setTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)setElementsAlpha:(CGFloat)alpha {
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
        [self bringSubviewToFront:view];
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
        [self bringSubviewToFront:view];

    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    [self bringSubviewToFront:titleView];

}

- (void)reset {
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

// 显示导航栏下面的分割线
- (void)showNavigationBarBottomLineView {
    [self setShadowImage:nil];
}

// 隐藏导航栏下面的分割线
- (void)hiddenNavigationBarBottomLineView {
    [self setShadowImage:[[UIImage alloc] init]];
}


@end
