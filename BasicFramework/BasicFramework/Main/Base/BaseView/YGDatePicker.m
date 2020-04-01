//
//  YGDatePicker.m
//  CashBack
//
//  Created by Rainy on 2017/10/17.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "YGDatePicker.h"

@interface YGDatePicker ()

@property(nonatomic,strong)UIDatePicker *datePickerView;

@property(nonatomic,strong)UIView *determineView;

@property(nonatomic,strong)UIView *backView;

@end

@implementation YGDatePicker

+ (instancetype)sharedDatePicker {
    
    static YGDatePicker *datePicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!datePicker) {
            datePicker = [YGDatePicker new];
        }
    });
    return datePicker;
}

static void(^_determineChoose)(NSString *dateString);
+ (void)showDateDetermineChoose:(void(^)(NSString *dateString))determineChoose
{
    [[YGDatePicker sharedDatePicker] showDateDetermineChoose:determineChoose];
}
- (void)showDateDetermineChoose:(void(^)(NSString *dateString))determineChoose
{
    _determineChoose = determineChoose;
    YGDatePicker *picker = [YGDatePicker sharedDatePicker];
    [kWindow addSubview:picker.backView];
    [kWindow addSubview:picker.datePickerView];
    [kWindow addSubview:picker.determineView];
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        picker.backView.alpha = kAlpha;
        picker.datePickerView.Y -= picker.datePickerView.Sh + 30;
        picker.determineView.Y -= picker.datePickerView.Sh + 30;
    }];
}
- (void)disapper
{
    YGDatePicker *picker = [YGDatePicker sharedDatePicker];
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{
        
        picker.backView.alpha = 0;
        picker.datePickerView.Y = kScreenHeight + 30;
        picker.determineView.Y = kScreenHeight;
        
    } completion:^(BOOL finished) {
        
        [picker.backView removeFromSuperview];
        [picker.datePickerView removeFromSuperview];
        [picker.determineView removeFromSuperview];
        
        picker.backView = nil;
        picker.datePickerView = nil;
        picker.determineView = nil;
        
    }];
}
- (void)determineAction:(UIButton *)BT
{
    NSDate *date = self.datePickerView.date;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [format stringFromDate:date];
    _determineChoose(dateString);
    [self disapper];
}
#pragma mark - lazy
- (UIDatePicker *)datePickerView
{
    if (!_datePickerView) {
        
        _datePickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, kScreenHeight + 30, kScreenWidth, kScreenHeight/4)];
        _datePickerView.backgroundColor = WhiteColor;
        
        _datePickerView.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_ch"];
        _datePickerView.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
        
        _datePickerView.datePickerMode = UIDatePickerModeDate;
    }
    return _datePickerView;
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
