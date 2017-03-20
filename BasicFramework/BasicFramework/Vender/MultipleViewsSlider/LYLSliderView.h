//
//  LYLSliderView.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/20.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, sliderWidthType) {
    ButtonWidth = 1,
    ButtonTitleWidth,
};

@class LYLSliderView;

@protocol LYLSliderViewDelegate <NSObject>

@required
-(void)sliderView:(LYLSliderView *)sliderView didSelectItemAtIndex:(NSInteger )index title:(NSString *)title;

@end

@interface LYLSliderView : UIView

@property(nonatomic,assign)sliderWidthType slider_Width_Type;

@property(nonatomic,assign)id<LYLSliderViewDelegate> delegate;

@property(nonatomic,strong)NSArray *titles_array;

@property(nonatomic,strong)UIColor *selectedColor;

@property(nonatomic,strong)UIColor *normalColor;

@property(nonatomic,strong)UIColor *sliderLineColor;

@property(nonatomic,assign)CGFloat slider_height;

@property(nonatomic,strong)UIFont *title_Font;

@property(nonatomic,strong)UIColor *edgeLineColor;

-(void)setCurrentItemAtIndex:(NSInteger )index;

@end
