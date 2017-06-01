
#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property(nonatomic)CGFloat cornerRad;
@property(nonatomic)CGFloat Cy;
@property(nonatomic)CGFloat Cx;

@property(nonatomic,assign)CGFloat X;
@property(nonatomic,assign)CGFloat Y;
@property(nonatomic,assign)CGFloat Sh;
@property (nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGFloat Sw;

-(void)setBlurStyle:(UIBlurEffectStyle)style;
-(void)removeBlur;

#pragma mark - Create Table for button
+(UIView *)CreateTableWithFrame:(CGRect )frame Number:(int)Number spacing:(CGFloat)spacing;

#pragma mark - TapAction LongPressAction
- (void)setTapActionWithBlock:(void (^)(void))block;
- (void)setLongPressActionWithBlock:(void (^)(void))block;

/**
 *  添加圆角边框
 */
-(void)addBorderWithcornerRad:(CGFloat)cornerRad lineCollor:(UIColor *)collor lineWidth:(CGFloat)lineWidth;
/**
 *  加载
 */
-(void)startLoading;
-(void)stopLoding;

/**
 *  切某一方向的圆角
 */
-(void)viewCutRoundedOfRectCorner:(UIRectCorner)rectCorner cornerRadii:(CGFloat)cornerRadii;
/**
 *  获取view的所在控制器
 */
-(UIViewController*)MyViewController;

@end
