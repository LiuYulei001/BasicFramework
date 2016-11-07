

#import "UIView+Extension.h"
#import <objc/runtime.h>

static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;

@implementation UIView (Extension)

- (void)setTapActionWithBlock:(void (^)(void))block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
        if (action)
        {
            action();
        }
    }
}

- (void)setLongPressActionWithBlock:(void (^)(void))block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);
    
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        
        if (action)
        {
            action();
        }
    }
}

-(void)setCornerRad:(CGFloat)cornerRad
{
    self.layer.cornerRadius = cornerRad;
    self.layer.masksToBounds = YES;
    
}
-(CGFloat)cornerRad
{
    return self.cornerRad;
}
-(void)setCy:(CGFloat)Cy
{
    CGPoint center = self.center;
    center.y = Cy;
    self.center = center;
}
-(CGFloat)Cy
{
    return self.center.y;
}
-(void)setCx:(CGFloat)Cx
{
    CGPoint center = self.center;
    center.x = Cx;
    self.center = center;
}
-(CGFloat)Cx
{
    return self.center.x;
}
-(void)setSh:(CGFloat)Sh
{
    CGRect fram = self.frame;
    fram.size.height = Sh;
    self.frame = fram;
}
-(CGFloat)Sh
{
    return self.frame.size.height;
}
-(void)setSw:(CGFloat)Sw
{
    CGRect fram = self.frame;
    fram.size.width = Sw;
    self.frame = fram;
}
-(CGFloat)Sw
{
    return self.frame.size.width;
}

-(CGFloat)X
{
    return self.frame.origin.x;
}
-(CGFloat)Y
{
    return self.frame.origin.y;
}
-(void)setX:(CGFloat)X
{
    CGRect frame = self.frame;
    frame.origin.x = X;
    self.frame = frame;
}
-(void)setY:(CGFloat)Y
{
    CGRect frame = self.frame;
    frame.origin.y = Y;
    self.frame = frame;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

-(void)setBlurStyle:(UIBlurEffectStyle)style
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.bounds;
    [self addSubview:effectView];
}
+(UIView *)CreateTableWithFrame:(CGRect )frame Number:(int)Number spacing:(CGFloat)spacing
{
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    
    
    CGRect rect = CGRectMake(0, 0, view.Sw/Number - spacing, view.Sh/Number - spacing);
    
    
    
    for (int i = 1 ; i <= Number; i++ ) {
        for (int j = 1; j <= Number; j++) {
            UIButton *button = [[UIButton alloc]initWithFrame:rect];
            [view addSubview:button];
            [button setBackgroundColor:[UIColor brownColor]];
            rect = CGRectOffset(rect, view.Sw/Number , 0);
            if (j == Number) {
                
                button.Sw += view.Sw - CGRectGetMaxX(button.frame);
            }
            
            if (i == Number) {
                
                button.Sh += view.Sh - CGRectGetMaxY(button.frame);
            }
        }
        
        rect.origin.x = 0;
        rect.origin.y = rect.origin.y + view.Sh/Number;
        
        
    }

    
    return view;
}


@end
