
#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property(nonatomic)CGFloat cornerRad;
@property(nonatomic)CGFloat Cy;
@property(nonatomic)CGFloat Cx;

@property(nonatomic,assign)CGFloat X;
@property(nonatomic,assign)CGFloat Y;
@property(nonatomic,assign)CGFloat Sh;
@property (nonatomic, assign)CGSize size;
@property(nonatomic,assign)CGFloat Sw;

-(void)setBlurStyle:(UIBlurEffectStyle)style;

#pragma mark - Create Table
+(UIView *)CreateTableWithFrame:(CGRect )frame Number:(int)Number spacing:(CGFloat)spacing;

#pragma mark - TapAction LongPressAction
- (void)setTapActionWithBlock:(void (^)(void))block;
- (void)setLongPressActionWithBlock:(void (^)(void))block;

@end
