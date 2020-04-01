//
//  YGOptionPicker.m
//  CashBack
//
//  Created by Rainy on 2017/10/17.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "YGOptionPicker.h"

@interface YGOptionPicker ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIPickerView *optionPickerView;

@property(nonatomic,strong)NSArray *dataSource;

@property(nonatomic,strong)UIView *determineView;

@property(nonatomic,strong)UIView *backView;

@end

@implementation YGOptionPicker

+ (instancetype)sharedOptionPicker {
    
    static YGOptionPicker *optionPicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!optionPicker) {
            optionPicker = [YGOptionPicker new];
        }
    });
    return optionPicker;
}
static void(^_determineChoose)(NSInteger index,NSString *title);
+ (void)showOptionPicker:(NSArray *)dataSource
         determineChoose:(void(^)(NSInteger index,NSString *title))determineChoose
{
    [[YGOptionPicker sharedOptionPicker] showOptionPicker:dataSource determineChoose:determineChoose];
}
- (void)showOptionPicker:(NSArray *)dataSource
         determineChoose:(void(^)(NSInteger index,NSString *title))determineChoose
{
    _determineChoose = determineChoose;
    YGOptionPicker *picker = [YGOptionPicker sharedOptionPicker];
    picker.dataSource = dataSource;
    [kWindow addSubview:picker.backView];
    [kWindow addSubview:picker.optionPickerView];
    [kWindow addSubview:picker.determineView];
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        picker.backView.alpha = kAlpha;
        picker.optionPickerView.Y -= picker.optionPickerView.Sh + 30;
        picker.determineView.Y -= picker.optionPickerView.Sh + 30;
    }];
}
- (void)disapper
{
    YGOptionPicker *picker = [YGOptionPicker sharedOptionPicker];
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        picker.backView.alpha = 0;
        picker.optionPickerView.Y = kScreenHeight + 30;
        picker.determineView.Y = kScreenHeight;
        
    } completion:^(BOOL finished) {
        
        [picker.backView removeFromSuperview];
        [picker.optionPickerView removeFromSuperview];
        [picker.determineView removeFromSuperview];
        
        picker.backView = nil;
        picker.optionPickerView = nil;
        picker.determineView = nil;
        
    }];
}


#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}
#pragma mark UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataSource[row];
}

- (void)determineAction:(UIButton *)BT
{
    NSInteger row = [self.optionPickerView selectedRowInComponent:0];
    NSString *titleStr = self.dataSource[row];
    [self disapper];
    _determineChoose(row,titleStr);
}

#pragma mark - lazy
- (UIPickerView *)optionPickerView
{
    if (!_optionPickerView) {
        
        _optionPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight + 30, kScreenWidth, kScreenHeight/4)];
        _optionPickerView.showsSelectionIndicator = YES;
        _optionPickerView.backgroundColor = WhiteColor;
        _optionPickerView.delegate = self;
        _optionPickerView.dataSource = self;
    }
    return _optionPickerView;
}
- (UIView *)determineView
{
    if (!_determineView) {
        
        _determineView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 30)];
        _determineView.backgroundColor = WhiteColor;
        UIButton *determineBT = [UIButton buttonWithType:UIButtonTypeSystem];
        [determineBT setTitleColor:ThemeColor forState:UIControlStateNormal];
        [determineBT setTitle:@"确定" forState:UIControlStateNormal];
        determineBT.frame = CGRectMake(_determineView.Sw - 70, 0, 70, 30);
        determineBT.titleLabel.font = SeventeenFontSize;
        [determineBT addTarget:self action:@selector(determineAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_determineView addSubview:determineBT];
    }
    return _determineView;
}
-(UIView *)backView
{
    if (!_backView) {
        
        _backView = [[UIView alloc]initWithFrame:kScreenBounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
        _backView.userInteractionEnabled = YES;
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

@end
