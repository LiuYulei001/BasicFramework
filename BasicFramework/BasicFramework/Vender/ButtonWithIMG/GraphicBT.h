

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GraphicBT_Type) {
    GraphicBT_Type_IMGUP = 1,
    GraphicBT_Type_IMGLEFT,
    GraphicBT_Type_IMGRIGHT,
};

@interface GraphicBT : UIButton

- (instancetype)initWithFrame:(CGRect)frame withIMG:(UIImage *)img title:(NSString *)title type:(GraphicBT_Type)type;

@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)UIImage *image;


@end
