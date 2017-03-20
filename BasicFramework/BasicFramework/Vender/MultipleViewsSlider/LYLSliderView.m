//
//  LYLSliderView.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/20.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "LYLSliderView.h"

@interface LYLSliderView ()<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *item_array;

@property(nonatomic,strong)UIButton *selected_item;

@property(nonatomic,assign)CGFloat item_SW;

@property(nonatomic,strong)UIView *sliderLine;

@property(nonatomic,strong)UIScrollView *scrollView;

@end


@implementation LYLSliderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.slider_height = 3;
        self.backgroundColor = [UIColor whiteColor];
        self.selectedColor = [UIColor redColor];
        self.normalColor = [UIColor blackColor];
        self.sliderLineColor = [UIColor redColor];
        
        self.slider_Width_Type = 1;
        self.clipsToBounds = YES;
        
    }
    return self;
}
#pragma mark - lazy
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(self.item_SW * self.titles_array.count, self.Sh);
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}
-(UIView *)sliderLine
{
    if (!_sliderLine) {
        
        _sliderLine = [[UIView alloc]init];
        [self addSubview:_sliderLine];
        [self bringSubviewToFront:_sliderLine];
        _sliderLine.layer.cornerRadius = 1;
        _sliderLine.layer.masksToBounds = YES;
    }
    return _sliderLine;
}
-(NSMutableArray *)item_array
{
    if (!_item_array) {
        
        _item_array = [NSMutableArray array];
    }
    return _item_array;
}
-(CGFloat)item_SW
{
    if (!_item_SW) {
        
        if (self.titles_array.count >= 5) {
            
            _item_SW = self.Sw / 5;
            
        }else
        {
            _item_SW = self.Sw / self.titles_array.count;
        }
    }
    return _item_SW;
}
#pragma mark - seting
-(void)setTitles_array:(NSArray *)titles_array
{
    _titles_array = titles_array;
    
    for (int i = 0; i < self.titles_array.count; i++) {
        
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        [item setTitle:self.titles_array[i] forState:UIControlStateNormal];
        [item setTitleColor:self.selectedColor forState:UIControlStateNormal];
        [item setTitleColor:self.selectedColor forState:UIControlStateSelected];
        [item setTitleColor:self.selectedColor forState:UIControlStateHighlighted];
        item.frame = CGRectMake(i * self.item_SW, 0, self.item_SW, self.Sh);
        if (self.title_Font) {
            
            [item.titleLabel setFont:self.title_Font];
        }else
        {
            [item.titleLabel setFont:[UIFont systemFontOfSize:15]];
        }
        item.adjustsImageWhenDisabled = NO;
        item.adjustsImageWhenHighlighted = NO;
        [item addTarget:self action:@selector(subBT_Click:) forControlEvents:UIControlEventTouchUpInside];
        [self.item_array addObject:item];
        [self.scrollView addSubview:item];
    }
    UIButton *first_item = self.item_array.firstObject;
    self.sliderLine.backgroundColor = self.sliderLineColor;
    self.sliderLine.frame = CGRectMake(_sliderLine.X, first_item.Sh - self.slider_height, _sliderLine.Sw, _sliderLine.Sh);
    [self selectorBT_beFirst:YES item:first_item];
    
}
-(void)setSlider_height:(CGFloat)slider_height
{
    _slider_height = slider_height;
    self.sliderLine.Sh = slider_height;
    self.sliderLine.Y = self.Sh - slider_height;
}
-(void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    [self reloadItem_Colors];
}
-(void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    [self reloadItem_Colors];
}
-(void)setSliderLineColor:(UIColor *)sliderLineColor
{
    _sliderLineColor = sliderLineColor;
    self.sliderLine.backgroundColor = sliderLineColor;
}
-(void)setEdgeLineColor:(UIColor *)edgeLineColor
{
    _edgeLineColor = edgeLineColor;
    UIView *line_down = [[UIView alloc]initWithFrame:CGRectMake(0, self.Sh - 1, self.Sw, 1)];
    line_down.backgroundColor = edgeLineColor;
    [self addSubview:line_down];
    [self sendSubviewToBack:line_down];
}

#pragma mark - action
-(void)reloadItem_Colors
{
    for (UIButton *item in self.item_array) {
        
        [item setTitleColor:self.normalColor forState:UIControlStateNormal];
    }
    UIButton *first_item = self.item_array.firstObject;
    [first_item setTitleColor:self.selectedColor forState:UIControlStateNormal];
    
}
-(void)subBT_Click:(UIButton *)item
{
    if (item == self.selected_item) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderView:didSelectItemAtIndex:title:)]) {
        
        [self.delegate sliderView:self didSelectItemAtIndex:[self.item_array indexOfObject:item] title:item.titleLabel.text];
        [self selectorBT_beFirst:NO item:item];
    }
    
}
-(void)selectorBT_beFirst:(BOOL)beFirst item:(UIButton *)item
{
    self.selected_item = item;
    [item setTitleColor:self.selectedColor forState:UIControlStateNormal];
    [self otherItemColorWithSelectedItem:item];
    
    CGFloat offSet = item.Cx - self.Sw * 0.5;
    
    CGFloat max = self.scrollView.contentSize.width - self.Sw;
    
    if (offSet < 0 || self.scrollView.contentSize.width < self.scrollView.Sw) {
        
        offSet = 0;
    }
    if (offSet > max) {
        offSet = max;
    }
    CGRect rect = [self.selected_item convertRect:self.scrollView.frame toView:self];
    CGFloat width;
    if (self.slider_Width_Type == 1) {
        
        width = item.Sw;
    }else
    {
        width = [item.titleLabel.text sizeWithFont:item.titleLabel.font andMaxW:MAXFLOAT].width;
    }
    
    if (beFirst) {
        
        self.sliderLine.frame = CGRectMake(rect.origin.x + (self.item_SW - width)/2, self.sliderLine.Y, width, self.slider_height);
        
    }else
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            self.sliderLine.frame = CGRectMake(rect.origin.x + (self.item_SW - width)/2, self.sliderLine.Y, width, self.slider_height);
            self.scrollView.contentOffset = CGPointMake(offSet, 0);
        }];
    }
    
}
-(void)otherItemColorWithSelectedItem:(UIButton *)item
{
    for (UIButton *temp_item in self.item_array) {
        if (temp_item == item) {
            
            continue;
        }
        [temp_item setTitleColor:self.normalColor forState:UIControlStateNormal];
    }
}
-(void)setCurrentItemAtIndex:(NSInteger )index
{
    if (index < 0 || index > self.item_array.count - 1) {
        
        return;
    }
    UIButton *item = self.item_array[index];
    [self selectorBT_beFirst:NO item:item];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect rect = [self.selected_item convertRect:self.scrollView.frame toView:self];
    CGFloat width;
    if (self.slider_Width_Type == 1) {
        
        width = self.selected_item.Sw;
    }else
    {
        width = [self.selected_item.titleLabel.text sizeWithFont:self.selected_item.titleLabel.font andMaxW:MAXFLOAT].width;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.sliderLine.frame = CGRectMake(rect.origin.x + (self.item_SW - width)/2, self.sliderLine.Y, width, self.slider_height);
    }];
    
}


@end
